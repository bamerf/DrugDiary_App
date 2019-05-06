create database druglog_app;

create table logs(
  id SERIAL PRIMARY KEY,
  user_id INTEGER,
  submit_date DATE,
  experience_name VARCHAR(300),
  gender VARCHAR(300),
  age VARCHAR(300),
  body_weight VARCHAR(300),
  drug VARCHAR(300),
  dosage VARCHAR(300),
  purity VARCHAR(300),
  prior_experience VARCHAR(300),
  substance_consumption VARCHAR(300),
  food VARCHAR(300),
  hydration VARCHAR(300),
  weather VARCHAR(300),
  temprature VARCHAR(300),
  environment VARCHAR(300),
  group_environment VARCHAR(300),
  mood_before VARCHAR(300),
  intensity VARCHAR(300),
  visuals VARCHAR(300),
  euphoria VARCHAR(300),
  fear VARCHAR(300),
  revelations VARCHAR(300),
  experience VARCHAR(300),
  user_recommendation VARCHAR(300),
  notes TEXT
);

create table users(
  id SERIAL PRIMARY KEY,
  email VARCHAR(500),
  password_digest VARCHAR(500) --name is convention
);

create table likes(
  id SERIAL PRIMARY KEY,
  log_id INTEGER,
  user_id INTEGER
);