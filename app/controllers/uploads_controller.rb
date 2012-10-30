class UploadsController < ApplicationController
  def employees
    if request.post? && params[:csv].present?
      infile = params[:csv].read.gsub(",=", ',')
      n, errs, headers = 0, [], []
      CSV.parse(infile) do |row|
        n += 1
        if n == 1
          headers = row.map {|i| i.to_s.downcase.parameterize.underscore.to_sym }
          next
        end
        # skip blank row
        next if row.join.blank?

        line = {}
        headers.each_with_index {|header, index| line[header] = row[index]}

        puts line.inspect

        logger.info "importing: #{line.inspect}"
        if employee = Employee.where(email_address: line[:email_address]).first
          employee.update_attributes! line
        else
          employee = Employee.create! line
        end
        begin
          employee.date_joined = Date.parse(employee.start_date_dd_mm_yy) if employee.start_date_dd_mm_yy
        rescue Exception => e
          logger.error "#{e.message} #{e.backtrace}"
        end

        if employee.status == nil || (employee.team && employee.team.downcase == 'executive')
          employee.votable = false
          employee.save!
        end

      end
    end
    redirect_to root_url, notice: 'CSV uploaded successfully'
  end

  def salaries
    if request.post? && params[:csv].present? && params[:period].present?
      infile = params[:csv].read.gsub(",=", ',')

      salary_table = {}
      total_salaries = 0.0
      n, errs, headers = 0, [], []
      CSV.parse(infile) do |row|
        n += 1
        if n == 1
          headers = row.map {|i| i.to_s.downcase.parameterize.underscore.to_sym }
          next
        end
        # skip blank row
        next if row.join.blank?

        line = {}
        headers.each_with_index {|header, index| line[header] = row[index]}

        salary_table[line[:email_address]] = line[:salary]
        total_salaries += line[:salary].to_f
      end

      salary_table.each do |email_address, salary|
        if user = User.where(email_address: email_address).first
          ballot = user.ballots.where(period: params[:period]).first
          ballot.adjustment_factor = (salary.to_f / total_salaries.to_f)
          ballot.save!
        end
      end
    end
    @results = Ballot.compute_results(params[:period])
    if result = Result.where(period: params[:period]).first
      result.update_attributes! period: params[:period], lines: @results
    else
      result = Result.create! period: params[:period], lines: @results
    end
    redirect_to result
  end
end
