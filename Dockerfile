# Docker image build for r-base latest with odbc and snowflake support
FROM r-base:4.2.0

# Install unixodbc and dependencies
RUN apt-get -y update
RUN apt-get install -y apt-utils gnupg odbcinst libodbc1 unixodbc

# Download latest snowflake driver and install it
RUN wget https://sfc-repo.snowflakecomputing.com/odbc/linux/2.24.7/snowflake-odbc-2.24.7.x86_64.deb
RUN dpkg -i snowflake-odbc-2.24.7.x86_64.deb
RUN apt-get install -f
RUN ln -s /usr/lib/x86_64-linux-gnu/libodbcinst.so.2 /usr/lib/x86_64-linux-gnu/libodbcinst.so.1
RUN sed -i 's/SF_ACCOUNT/sony/' /etc/odbc.ini
