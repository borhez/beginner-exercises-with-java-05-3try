drop schema if exists chat cascade;
create schema chat;
create table chat.user(
    id          serial primary key,
    login        varchar(30) not null unique,
    password    varchar(30) not null
);
create table chat.chatroom (
    id              serial primary key,
    nameChatroom   varchar(30) not null unique,
    owner           integer not null,
    foreign key (owner) references chat.user(id)
);

create table chat.message (
    id          serial primary key,
    author      integer not null,
    room        integer not null,
    text        text not null,
    lDateTime   timestamp default CURRENT_TIMESTAMP,
    foreign key (author) references chat.user(id),
    foreign key (room) references chat.chatroom(id)
);