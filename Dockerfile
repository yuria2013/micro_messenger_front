FROM registry.access.redhat.com/ubi8/ubi:latest

# Install Apache httpd
RUN dnf -y install httpd && \
    dnf clean all

# Set ServerName to suppress warnings
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

# Change Apache to listen on port 8080
RUN sed -i 's/^Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf

# Update the error log path if necessary
RUN sed -i 's|^ErrorLog .*|ErrorLog /var/log/httpd/error_log|' /etc/httpd/conf/httpd.conf

# Create necessary directories and set permissions
RUN mkdir -p /var/log/httpd && \
    chown -R apache:apache /var/log/httpd && \
    chmod 755 /var/log/httpd

# Copy HTML files to the Apache directory
COPY ./ /var/www/html/

# Expose port 8080 for the web server
EXPOSE 8080

# Start Apache in the foreground
CMD ["httpd", "-D", "FOREGROUND"]
