# Full-Stack FastAPI and React Template - DevOps November CV Challenge

Welcome to the **Full-Stack FastAPI and React Template** repository! This project serves as a demo application for the **DevOps November Resume Challenge**, where participants will deploy a full-stack application with a **FastAPI** backend and **ReactJS** frontend using **ChakraUI**. Additionally, participants will set up monitoring and logging tools, configure a reverse proxy, and deploy the application to a cloud platform, showcasing their end-to-end DevOps skills.

---

## Challenge Overview

As part of this challenge, your primary goal is to:

1. Dockerize a full-stack application with a FastAPI backend and React frontend.
2. Configure and deploy monitoring and logging tools including Prometheus, Grafana, Loki, Promtail, and cAdvisor.
3. Set up a reverse proxy for application routing.
4. Deploy the application to a cloud platform with proper domain configuration.
5. Submit a working repository with detailed documentation and screenshots of your deployed application.

---

## Challenge Requirements

1. **Dockerization and Orchestration**:  
   - Write `Dockerfile`s to containerize both the **React frontend** and **FastAPI backend**.
   - Create two `docker-compose.yml` files:
     1. **Application Stack Compose**:  
        Orchestrate the following services:
        - React frontend.
        - FastAPI backend.
        - PostgreSQL database.
        - Adminer (for database management).
        - Reverse Proxy (Traefik or Nginx Proxy Manager).
     2. **Monitoring Stack Compose**:  
        Orchestrate the following services:
        - Prometheus.
        - Grafana.
        - Loki and Promtail.
        - **cAdvisor** for monitoring container performance.
     - Ensure both Docker Compose files are connected to a common Docker network to allow inter-container communication.

2. **Reverse Proxy Configuration**:  
   Use **Traefik** or **Nginx Proxy Manager** in the **Application Stack Compose** to:
   - Serve the **frontend** on `/` (the root path).
   - Proxy `/api` to the FastAPI backend.
   - Proxy `/docs` to the FastAPI backend's Swagger documentation.
   - Proxy `/prometheus` to the Prometheus web UI (via the Monitoring Stack).
   - Proxy `/grafana` to the Grafana web UI (via the Monitoring Stack).
   - Ensure all routes are properly secured and accessible.

3. **Database Configuration**:  
   - Use PostgreSQL as the backend database.
   - Configure Adminer for database management and ensure it is accessible via `db.domain`.

4. **Monitoring and Logging**:  
   - Set up the following tools using the **Monitoring Stack Compose**:
     - **Prometheus** for collecting application metrics.
     - **Grafana** for visualizing metrics and logs.
     - **Loki** and **Promtail** for log aggregation and forwarding.
     - **cAdvisor** to monitor container metrics and performance.
   - Ensure Prometheus is scraping metrics from the backend, and Grafana is configured with dashboards for logs and metrics.
   - Ensure that all monitoring dashboards (Prometheus, Grafana, and cAdvisor) are routed through the reverse proxy (Traefik or Nginx Proxy Manager) in the **Application Stack Compose**.
   - Create a cAdvisor Dashboard in Grafana**:
     - Integrate **cAdvisor** with **Grafana** to display container performance metrics such as CPU usage, memory usage, disk I/O, and network I/O.
     - Create a custom Grafana dashboard that visualizes container metrics from cAdvisor.
     - Ensure the dashboard has proper panels for the most important container metrics.

   - Add Loki as a Data Source in Grafana**:
     - Integrate **Loki** into **Grafana** to enable log aggregation and visualization.
     - Ensure that **Loki** is set up as a data source in **Grafana** and logs from the application and containers are sent to it.
     - Include a panel in Grafana that visualizes logs from Loki, which could be useful for troubleshooting or monitoring application performance.

5. **Cloud Deployment**:  
   - Deploy the application stack to a cloud platform (AWS, GCP, or Azure) using Docker Compose.
   - Set up a domain for your application (e.g., `your-app.domain.com`).
   - If you don’t have a domain, obtain a free subdomain from [Afraid DNS](https://freedns.afraid.org/).
   - Configure:
     - HTTP to redirect to HTTPS.
     - `www` to redirect to the non-`www` domain.

6. **Article**:  
   - Write and publish a detailed **Article** about the project. Your article should include:
     - An overview of the project and its purpose.
     - Step-by-step instructions on how you containerized, orchestrated, and deployed the application.
     - Screenshots of your setup, including:
       - The deployed application.
       - Grafana dashboards showing metrics and logs.
       - Reverse proxy configuration.
     - Challenges you faced and how you resolved them.
     - Lessons learned and tips for others.
   - Include the link to your Medium article in your submission.
---
## Project Structure

The repository is organized as follows:

- **frontend**: Contains the ReactJS application.
- **backend**: Contains the FastAPI application and PostgreSQL database integration.

Each directory includes its own README file with detailed instructions:

- [Frontend README](./frontend/README.md)
- [Backend README](./backend/README.md)

---

## Getting Started

### Clone the Repository

Start by cloning this repository to your local machine:

```bash
git clone <repository-url>
cd <repository-folder>
```


## Testing and Evaluation

Your hosted application will be evaluated based on the following criteria:  

1. **Dockerization**:  
   - Verify that the `Dockerfile`s and `docker-compose.yml` work seamlessly to build and run the application.  

2. **Reverse Proxy**:  
   - Confirm that the application routes are correctly configured (frontend on `/`, backend `/api`, and backend docs `/docs`).  

3. **Database Setup**:  
   - Ensure PostgreSQL is properly configured and Adminer is accessible via `db.domain`.  

4. **Monitoring and Logging**:  
   - Test that Prometheus scrapes application metrics and Grafana displays metrics and logs.
   - Ensure that cAdvisor metrics are displayed properly in the Grafana dashboard.
   - Ensure that Logs from Loki Can be visualized in Grafana.

5. **Cloud Deployment**:  
   - Confirm the application is deployed to the cloud and accessible via a public URL.  
   - Check that HTTP redirects to HTTPS, and `www` redirects to the non-`www` domain.  

6. **Repository Validation**:  
   - Verify that running `docker-compose up -d` from your repository correctly deploys the application and all supporting services.  

7. **Article**:  
   - Evaluate the clarity, detail, and technical depth of the published article.  


---

## Submission Guidelines

1. Deploy the application stack and ensure all services are running correctly.  
2. Submit the following:  
   - A link to your **GitHub repository** containing all files (`Dockerfile`, `docker-compose.yml`, configurations, etc.).  
   - A link to your **Article**.  
   - Screenshots of:  
     - The deployed application.  
     - Metrics and logs displayed in Grafana.  
     - Reverse proxy routes and configurations.  

---


Good luck with this Challenge! This is your opportunity to showcase your end-to-end DevOps skills and stand out to potential employers.



# Managing Multiple Python Versions on macOS and Resolving Conflicts

## **Introduction**
macOS comes with a system-installed version of Python, but many users install additional versions via Homebrew, the official Python installer, or pyenv. This can lead to conflicts when executing `python3` or `pip3`. This guide explains how to manage multiple Python versions on macOS and ensure the correct version is used.

---
## **Checking Installed Python Versions**
To see all installed Python versions, run:
```bash
which -a python3
```
Example output:
```
/Library/Frameworks/Python.framework/Versions/3.13/bin/python3
/usr/local/bin/python3
/usr/bin/python3
```
This indicates multiple Python installations:
- `/usr/bin/python3`: System Python (default macOS version, not recommended for modifications).
- `/usr/local/bin/python3`: Homebrew-installed Python.
- `/Library/Frameworks/Python.framework/Versions/3.13/bin/python3`: Python installed from the official Python website.

To check which Python version is currently active, use:
```bash
python3 --version
```

To check which `pip3` version is being used:
```bash
pip3 --version
```
Example output:
```
pip 24.3.1 from /Library/Frameworks/Python.framework/Versions/3.13/lib/python3.13/site-packages/pip (python 3.13)
```

---
## **Managing Python Versions**
### **Option 1: Using Homebrew’s Python as the Default**
If you installed Python using Homebrew and want it to be the default, ensure it’s correctly linked:
```bash
brew link --overwrite python@3.13
```
Then, update your shell configuration to prioritize Homebrew’s Python:
```bash
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.zshrc
source ~/.zshrc
```
Verify the change:
```bash
which python3
python3 --version
```
Expected output:
```
/usr/local/bin/python3
Python 3.13.x
```

### **Option 2: Using pyenv to Manage Python Versions**
If you prefer to switch between different Python versions dynamically, `pyenv` is a great tool. Install pyenv via Homebrew:
```bash
brew install pyenv
```
Add pyenv to your shell configuration:
```bash
echo 'export PATH="$HOME/.pyenv/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init --path)"' >> ~/.zshrc
source ~/.zshrc
```
Now, install and set a specific Python version:
```bash
pyenv install 3.13.2
pyenv global 3.13.2
```
Check the active Python version:
```bash
python3 --version
```
Expected output:
```
Python 3.13.2
```
If you ever need to switch versions temporarily, use:
```bash
pyenv local 3.12.1  # Switches to Python 3.12.1 in the current directory
```

### **Option 3: Removing Unwanted Python Installations**
If you want to remove conflicting versions:
- **Uninstall Homebrew Python:**
  ```bash
  brew uninstall python@3.13
  ```
- **Remove the Official Python Installation:**
  ```bash
  sudo rm -rf /Library/Frameworks/Python.framework
  sudo rm -rf /Applications/Python*
  sudo rm -rf /usr/local/bin/python*
  ```
- **Unlink Previously Installed Versions:**
  ```bash
  brew unlink python@3.13
  ```
  To relink a version:
  ```bash
  brew link python@3.13
  ```
- **Uninstall pyenv (if necessary):**
  ```bash
  brew uninstall pyenv
  rm -rf ~/.pyenv
  ```

---
## **Conclusion**
To manage multiple Python versions efficiently:
- **Use Homebrew’s Python** if you only need a single, up-to-date version.
- **Use pyenv** if you need multiple Python versions for different projects.
- **Clean up unnecessary installations** to avoid confusion.
- **Unlink and relink versions** to switch between Python installations as needed.

By following these steps, you can ensure that your Python development environment on macOS remains stable and conflict-free.

