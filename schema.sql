-- PromptHub Database Schema
-- A collaborative platform for AI prompt management

CREATE TABLE Users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    plan_type VARCHAR(20) DEFAULT 'free',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Prompts (
    prompt_id SERIAL PRIMARY KEY,
    creator_id INTEGER REFERENCES Users(user_id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    ai_model VARCHAR(50),
    is_public BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- LIIGENDTABEL (Junction Table)
-- Seob kasutajad ja prompid (üks kasutaja saab salvestada palju prompte)
CREATE TABLE SavedPrompts (
    save_id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES Users(user_id) ON DELETE CASCADE,
    prompt_id INTEGER NOT NULL REFERENCES Prompts(prompt_id) ON DELETE CASCADE,
    folder_name VARCHAR(50) DEFAULT 'General',
    saved_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE(user_id, prompt_id)
);
