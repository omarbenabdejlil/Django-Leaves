# Use an official Python runtime as a parent image
FROM python:3.9-slim


# Add Debian contrib repository
RUN echo "deb http://deb.debian.org/debian buster contrib" >> /etc/apt/sources.list

# Update packages and install libmysqlclient-dev
RUN apt-get update && \
    apt-get install -y libmariadb-dev-compat && \
    apt-get install -y libmariadb-dev


# Set the working directory to /app
WORKDIR /app
RUN pip install --upgrade setuptools
RUN pip install numpy
RUN pip install zope.interface==4.6.0

# Copy the requirements file into the container at /app
COPY requirements.txt /app

# Install any needed packages specified in requirements.txt
RUN pip install --trusted-host pypi.python.org -r requirements.txt

# Install mysql-client
RUN apt-get update && \
    apt-get install -y mysql-client && \
    rm -rf /var/lib/apt/lists/*

# Copy the rest of the app code into the container at /app
COPY . /app

# Set the default command to run when the container starts
CMD ["python", "app.py"]
