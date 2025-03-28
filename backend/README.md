# Backend - FastAPI with PostgreSQL

This directory contains the backend of the application built with FastAPI and a PostgreSQL database.

## Prerequisites

- Python 3.8 or higher
- Poetry (for dependency management)
- PostgreSQL (ensure the database server is running)

### Installing Poetry

To install Poetry, follow these steps:

```sh
curl -sSL https://install.python-poetry.org | python3 -
```

Add Poetry to your PATH (if not automatically added):

## Setup Instructions

1. **Navigate to the backend directory**:
    ```sh
    cd backend
    ```

2. **Install dependencies using Poetry**:
    ```sh
    poetry install
    ```

3. **Set up the database with the necessary tables**:
    ```sh
    poetry run bash ./prestart.sh
    ```

4. **Run the backend server**:
    ```sh
    poetry run uvicorn app.main:app --reload
    ```

5. **Update configuration**:
   Ensure you update the necessary configurations in the `.env` file, particularly the database configuration.

## to run the backend server on ec2

poetry run uvicorn app.main:app --host 0.0.0.0

then use <ip address:8000> to access it


# PostgreSQL Installation & Troubleshooting Guide (macOS)

This guide provides step-by-step instructions on installing, setting up, and troubleshooting PostgreSQL on macOS.

---

## **1️⃣ Installing PostgreSQL on macOS**
### **Using Homebrew (Recommended)**
To install PostgreSQL version 14 using Homebrew, run:
```bash
brew install postgresql@14
```
After installation, start PostgreSQL as a service:
```bash
brew services start postgresql@14
```

### **Verify Installation**
Check if PostgreSQL is running:
```bash
pg_isready
```
If you see `accepting connections`, PostgreSQL is running.

List installed services:
```bash
brew services list
```

---

## **2️⃣ Connecting to PostgreSQL**
### **Enter the `psql` Shell**
By default, PostgreSQL creates a role matching your macOS username. Try:
```bash
psql -U $(whoami)
```
To explicitly connect as `postgres`:
```bash
psql -U postgres
```
To connect to a specific database:
```bash
psql -U postgres -d mydatabase
```

### **Exit the `psql` Shell**
To exit PostgreSQL, type:
```sql
\q
```

---

## **3️⃣ Troubleshooting Common Issues**

### **❌ Error: "connection to server on socket '/tmp/.s.PGSQL.5432' failed"**
#### ✅ **Check if PostgreSQL is Running**
```bash
brew services list
```
If PostgreSQL is not running, start it:
```bash
brew services start postgresql@14
```
Manually start PostgreSQL:
```bash
pg_ctl -D /usr/local/var/postgres start
```
Verify if it's ready:
```bash
pg_isready
```

---

### **❌ Error: "FATAL: role 'postgres' does not exist"**
#### ✅ **Check Available Users**
```bash
psql -U $(whoami) -d postgres -c "\du"
```
If `postgres` is missing, create it:
```bash
createuser -U $(whoami) -s postgres
```
Or in `psql`:
```sql
CREATE ROLE postgres WITH SUPERUSER LOGIN PASSWORD 'your_secure_password';
```

---

### **❌ Error: "FATAL: database '<your_username>' does not exist"**
#### ✅ **Create a Database for Your User**
PostgreSQL tries to connect to a database matching your macOS username. If it doesn't exist, create it:
```bash
psql -U postgres -d postgres -c "CREATE DATABASE $(whoami);"
```
Now, try connecting again:
```bash
psql -U $(whoami) -d $(whoami)
```

---

### **❌ PostgreSQL Not Initialized**
If PostgreSQL wasn’t initialized properly, initialize it manually:
```bash
initdb /usr/local/var/postgres
```
Then restart the service:
```bash
brew services restart postgresql@14
```

---

## **4️⃣ List Users and Databases**
### **List All Users (Roles)**
Once inside the `psql` shell, run:
```sql
\du
```
Or use an SQL query:
```sql
SELECT rolname, rolsuper, rolcreatedb, rolcanlogin FROM pg_roles;
```

### **List All Databases**
```sql
\l
```
Or:
```sql
SELECT datname FROM pg_database;
```

---

## **5️⃣ Uninstalling PostgreSQL**
If you need to uninstall PostgreSQL, run:
```bash
brew uninstall postgresql@14
```
To remove all PostgreSQL data:
```bash
rm -rf /usr/local/var/postgres
```

---

## **6️⃣ Additional Resources**
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Homebrew PostgreSQL Formula](https://formulae.brew.sh/formula/postgresql)

This guide should help you install and troubleshoot PostgreSQL on macOS efficiently. 🚀



Here's a documentation snippet you can add to your `README.md` for changing or creating a PostgreSQL user password on your Mac:

---

## Changing or Creating a PostgreSQL User Password on Mac

Follow these steps to change or create a password for a PostgreSQL user on your Mac.

### Prerequisites:
- PostgreSQL 14 is installed and running on your Mac.
- You have access to the terminal.

### Steps:

1. **Access PostgreSQL shell**  
   Open the terminal and log in to PostgreSQL as the `postgres` superuser:
   ```bash
   psql -U postgres
   ```
   This will prompt you for the password (if configured).

2. **Change the password for an existing user**  
   To change the password for an existing user, run the following SQL command inside the `psql` shell:
   ```sql
   ALTER USER <username> WITH PASSWORD '<newpassword>';
   ```
   Replace `<username>` with the PostgreSQL username and `<newpassword>` with the desired password.

3. **Create a new user with a password**  
   To create a new user and set a password, use the following command:
   ```sql
   CREATE USER <newusername> WITH PASSWORD '<newpassword>';
   ```
   Replace `<newusername>` with the desired username and `<newpassword>` with the password for that user.

4. **Exit PostgreSQL**  
   Once the password has been updated or the new user is created, exit the `psql` shell:
   ```sql
   \q
   ```

### Example:

To change the password for a user named `testuser` to `newpassword`, run:
```sql
ALTER USER testuser WITH PASSWORD 'newpassword';
```

To create a new user named `newuser` with password `mypassword`, run:
```sql
CREATE USER newuser WITH PASSWORD 'mypassword';
```

---

# Fixing PostgreSQL Startup Error: "lock file "postmaster.pid" already exists"

## 🐞 Issue

When trying to start PostgreSQL on macOS using Homebrew, the following error occurred:

```plaintext
error 256 bankolejohn ~/Library/LaunchAgents/homebrew.mxcl.postgresql@14.plist
FATAL:  lock file "postmaster.pid" already exists
HINT:  Is another postmaster (PID 433) running in data directory "/usr/local/var/postgresql@14"?
```

### Cause

This happens when PostgreSQL thinks it’s already running because a `postmaster.pid` lock file exists in the data directory. The file is either from a running PostgreSQL instance or a leftover from a previous unclean shutdown.

---

## ✅ Solution: Remove the Stale Lock File

If PostgreSQL isn’t running, you can safely delete the stale lock file.

### Steps:

1. **Check if PostgreSQL is running:**

   ```bash
   ps -p 433
   ```

   Replace `433` with the PID shown in the error message. If no output appears, PostgreSQL isn’t running.

2. **Remove the ****`postmaster.pid`**** file:**

   ```bash
   rm /usr/local/var/postgresql@14/postmaster.pid
   ```

3. **Start PostgreSQL:**

   ```bash
   brew services start postgresql@14
   ```

4. **Verify the status:**

   ```bash
   pg_isready
   ```

   If the output says "accepting connections," PostgreSQL is running properly.

---

## 🔍 Additional Checks (Optional)

If removing the lock file doesn't fix the issue:

- **Stop any running PostgreSQL service:**
  ```bash
  brew services stop postgresql@14
  pkill postgres
  ```
- **Check the logs for errors:**
  ```bash
  cat /usr/local/var/postgresql@14/postgresql.log
  ```

---

## 🎉 Conclusion

Removing the stale `postmaster.pid` file fixed the issue, allowing PostgreSQL to start properly. This happens occasionally after unexpected shutdowns or crashes.

If you run into further issues, checking the logs and ensuring Homebrew services are properly managed can help troubleshoot.




