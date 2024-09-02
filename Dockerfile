# Use the latest RHEL image as the base image
FROM registry.access.redhat.com/ubi8/ubi:latest

# Install Apache httpd
RUN dnf -y install httpd && \
    dnf clean all

# Set ServerName to localhost to prevent 'Could not reliably determine the server's fully qualified domain name' warning
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

# Ensure proper permissions for the run directory to avoid PID file errors
RUN mkdir -p /run/httpd && \
    chown -R apache:apache /run/httpd && \
    chmod 755 /run/httpd

# Copy HTML files to the Apache directory
COPY ./html/ /var/www/html/

# Expose port 80 for the web server
EXPOSE 80

# Start Apache in the foreground
CMD ["httpd", "-D", "FOREGROUND"]
