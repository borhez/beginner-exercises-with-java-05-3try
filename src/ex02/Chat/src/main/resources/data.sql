INSERT INTO chat.user(login, password) VALUES
	('first', 'one'),
	('second', 'two'),
	('third', 'three'),
	('fourth', 'four'),
	('fifth', 'five')
;

INSERT INTO chat.chatroom(namechatroom, owner) VALUES
('chat1', (SELECT id FROM chat.user WHERE login = 'first')),
('chat2', (SELECT id FROM chat.user WHERE login = 'second')),
('chat3', (SELECT id FROM chat.user WHERE login = 'third')),
('chat4', (SELECT id FROM chat.user WHERE login = 'fourth')),
('chat5', (SELECT id FROM chat.user WHERE login = 'fifth'))
ON CONFLICT DO NOTHING;

INSERT INTO chat.message (author, room, text) VALUES
((SELECT id FROM chat.user WHERE login= 'first'),      (SELECT id FROM chat.chatroom WHERE nameChatroom = 'chat1'), 'Hi! I am first'),
((SELECT id FROM chat.user WHERE login = 'second'),      (SELECT id FROM chat.chatroom WHERE nameChatroom = 'chat2'), 'Hi! I am second'),
((SELECT id FROM chat.user WHERE login = 'third'), (SELECT id FROM chat.chatroom WHERE nameChatroom = 'chat3'), 'Hi! I am third'),
((SELECT id FROM chat.user WHERE login = 'fourth'),    (SELECT id FROM chat.chatroom WHERE nameChatroom = 'chat4'), 'Hi! I am fourth'),
((SELECT id FROM chat.user WHERE login = 'fifth'),  (SELECT id FROM chat.chatroom WHERE nameChatroom = 'chat5'), 'Hi! I am fifth')
ON CONFLICT DO NOTHING;

