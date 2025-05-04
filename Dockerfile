# Use the latest Arch Linux base image
FROM archlinux:base-devel

# Update the system and install distcc, clang, and its dependencies
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm distcc clang

# Configure distcc to allow connections from any host (for demonstration purposes)
# WARNING: This is not secure for production use. You should restrict access to trusted hosts.
RUN echo "ALLOWED_SERVERS='0.0.0.0/0'" >> /etc/conf.d/distccd && \
    echo "LISTENER='0.0.0.0'" >> /etc/conf.d/distccd

# Expose the default distcc port (3632)
EXPOSE 3632

# Start distccd in the foreground
CMD ["distccd", "--no-detach", "--log-level", "notice", "--log-stderr", "--allow", "0.0.0.0/0"]
