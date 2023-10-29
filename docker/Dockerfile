# Use an official Ansible base image
FROM ansible/ansible:latest

# Install the Google Cloud SDK
RUN apt-get update && apt-get install -y curl && \
    export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)" && \
    echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list && \
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add - && \
    apt-get update -y && apt-get install -y google-cloud-sdk

# Install any additional dependencies for your playbooks (e.g., Python modules)
#RUN pip install <dependency>

# Copy your Ansible playbooks and related files to the container
COPY laravelio-deploy.yml /ansible/playbooks/laravelio-deploy.yml
COPY laravelio-undeploy.yml /ansible/playbooks/laravelio-undeploy.yml
COPY laravelio-test.yml /ansible/playbooks/laravelio-test.yml
COPY laravelio-service.yaml /ansible/playbooks/laravelio-service.yaml

# Set the working directory to the location of your playbooks
WORKDIR /ansible/playbooks

# Run the Ansible playbooks
CMD ansible-playbook laravelio-test.yml