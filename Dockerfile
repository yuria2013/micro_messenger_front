FROM registry.access.redhat.com/ubi8/ubi:latest

# Install Apache httpd
RUN dnf -y install httpd && \
    dnf clean all

# Set ServerName to suppress warnings
RUN echo "ServerName localhost" >> /etc/httpd/conf/httpd.conf

# Change Apache to listen on port 8080
RUN sed -i 's/^Listen 80/Listen 8080/' /etc/httpd/conf/httpd.conf

# Create necessary directories and set permissions
RUN mkdir -p /run/httpd /var/log/httpd && \
    chown -R apache:apache /run/httpd /var/log/httpd && \
    chmod 755 /run/httpd /var/log/httpd

# Copy HTML files to the Apache directory
COPY ./ /var/www/html/

# Expose port 8080 for the web server
EXPOSE 8080

# Start Apache in the foreground
CMD ["httpd", "-D", "FOREGROUND"]
