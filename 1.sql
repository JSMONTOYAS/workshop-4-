SELECT *
FROM Video
JOIN User ON Video.user_id = User.user_id
WHERE User.country = 'Nombre del País';