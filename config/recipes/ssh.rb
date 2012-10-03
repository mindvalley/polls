namespace :ssh do
  task :setup do
    run "#{sudo} sed -i 's/Port 22/Port 20022/' /etc/ssh/sshd_config"
    run "#{sudo} sed -i '$ a\PasswordAuthentication no' /etc/ssh/sshd_config"
    run "#{sudo} sed -i '$ a\AllowUsers #{user}' /etc/ssh/sshd_config"
    run "#{sudo} sed -i '$ a\#{user}    ALL=NOPASSWD: ALL' /etc/sudoers"
    run "mkdir ~/.ssh"
    run "chmod -R 600 ~/.ssh/"
    run "chmod 700 ~/.ssh"
    run "touch ~/.ssh/authorized_keys"
    # TODO: make the keys into configuration vars
    run "echo \"ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEA1tpQvqm1XmxvIrlsXpDgAz04wj/us2ESCM9tetYiNjXsVaiYRq30j8TKIpLGGBhJRYSTP/HwD9Vxrbcn3/E9hVylLwCcrVYoigAOAwzBXDANEvHqZa18/TkrJAa7SNvgiXYkdxecISCDgBvooZT496X3VOD3YEo/zUaM6aYMXsbluFAjD0al0mEn1MYYmnxuRVtZwyKl8ccZ4Zd0OEL/unx9mePot71sPh9pYZ1LGtA4qLsYj3VmwQeYlWYfFMevtoAWjWP8mxAAC7GKoo4b7+zRygTX/FymERSFZvzxIAmJh2ZRJ+xG8HW5T31H24YC1uGYRfOYfH6QYIcQOy33gw== calvin@calvin-laptop\">> ~/.ssh/authorized_keys"
    run "echo \"ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAooCc65MqkbhEjw+ZZcOibVqLaxWxubFUwy+nqGxXX1irZHsvh1iDp0Lqq4Tik3uzHg54X1GnOkOu2LxaSZW2zlT7oi5qaor84kvJmb3LcCqoSqKmWuK0x77fSi0jdJW4v7vfwg5Qeb3TKlRdwO9i3/N+qTyw+lk2OINYkxcJf+XfeAsMsHjbvNMPe2gbdZmuN6tOXIuP16X0XLfWHrYtZSMWhgw3+eIX8rIk04qsZUEh0aI9pBnpPpP5pOh/sT6NiFO5YWr4S6OkTCfk/ZGXtU29L2QTTTaW8I6CPu/2Pc70JVheHdf8boMk+NNceUt6+3WEHZASspyX2b4oddRL5Q== tristan@mindvalley.com\">> ~/.ssh/authorized_keys"
    run "echo \"ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAIEAgEi9U+nkst8mk06CJj9p5itgqL0iuLJ2ZXpsLy/CJY0+gTp0F+IJ+pJV382/od3DmMeSWVNvuDXhz0vLoJuI8qP7rBwJvBvoWwouQtNTnEJJuX8w4LMTzbHzYD5K9WKWXIq386VLwmmMH7TQPgapVgSj0MZfRtoUiZqHWpiyk2U= gareth@mindvalley.com\">> ~/.ssh/authorized_keys"
    run "echo \"ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEApvVUAqryFUt6MhZqB/XgDKrhTv2i8xGLGILVe3aE+tNU+dCk3Ncv7xHL4SrwCQMkUSYiXxQVjvddIRG4aEwmJYvL3EeZCpEf2FcZjZneeCH3lNthRZn2SsWd0JZS+oRk0DTJL1SV5Nna8KiguIJZjS5HK0Q+U/5mQj3ZSBZJZwsx562aFj+nV0ReuOINgjDUX93bPiSZqF8g/hVEMkw1WzXM8Nax2/ATcvcVjDGIffRsN+Gb1djrKHoEdkIEY91aVXJhCRgCvv1flpG4JQ3fbIaopjoc0c/VFEAcDyBeWWnGv8y2df2FiATA81PhUHpiQiTUsyREXhRkepQgIa9Hxw== mvdev@cnc\">> ~/.ssh/authorized_keys"
    run "echo \"ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAspuBLqm4UGkQSPq1jfsdjl5VvjW7ovnn86liQdxy8PGm9hwdyoOmzl5+N+jytXFWtK7j+ls5l4kyJcCmYso3PDpMVcQrypy8DhbLZ6Qi7w1MzYJS9gAp/FBqFnFa35z6IGpuC0PksuzKsL9J0Wvb2E9g3FHrCvqNGfBqXBFDQDYhhm0nmyUcmpqmo7Gh3B0TXw4vo6etuihqKURT4sSG4jVl9+4Y3bjbvpqRrLun7JvLyf2yXkAlAvw5VogGddeuUm7LS4fuZmwdzDkNQh4QthkRD8PBtQAUm+77fvCNx/3WldXGKR3+TX7Y4kYh38wEiWlSF+F4rwVq/svmq+Jcvw== jimmy@mindvalley.com\">> ~/.ssh/authorized_keys"
  end
end
