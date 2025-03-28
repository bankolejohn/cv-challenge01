-- Create database schema
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    hashed_password VARCHAR(255) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);

-- Create admin user (password should be hashed)
INSERT INTO users (username, email, hashed_password)
VALUES (
    'admin',
    'admin@example.com',
    -- Example bcrypt hash for 'admin123' (replace with your actual hashed password)
    '$2b$12$EixZaYVK1fsbw1ZfbX3OXePaWxn96p36WQoeG6Lruj3vjPGga31lW'
) ON CONFLICT (email) DO NOTHING;

-- Set permissions for your database user
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO bankolejohn;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO bankolejohn;