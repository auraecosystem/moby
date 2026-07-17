-- Create users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- Seed mock data for development testing
INSERT INTO users (name, email) VALUES 
('Alice Vance', 'alice@example.com'),
('Bob Smith', 'bob@example.com')
ON CONFLICT (email) DO NOTHING;
