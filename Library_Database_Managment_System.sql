-- delete database if it exists already
DROP DATABASE IF EXISTS library_database;
-- create a new database
CREATE DATABASE IF NOT EXISTS library_database;

-- activating created database for use
USE library_database;

/* all operations starts from here */

-- initial creation of all necessary tables

-- Books List Table
CREATE TABLE IF NOT EXISTS books_list
(
    book_id  INTEGER(10) NOT NULL,
    group_id INTEGER(10) NOT NULL
);

CREATE TABLE IF NOT EXISTS book_group_list
(
    group_id     INTEGER(10) NOT NULL,
    category_id  INTEGER(5)  NOT NULL,
    title        VARCHAR(50) NOT NULL,
    publisher_id INTEGER(10) NOT NULL
);


-- Category List Table
CREATE TABLE IF NOT EXISTS categories_list
(
    category_id INTEGER(5)  NOT NULL,
    name        VARCHAR(50) NOT NULL,
    details     VARCHAR(100)
);

-- Authors List Table
CREATE TABLE IF NOT EXISTS authors_list
(
    author_id   INTEGER(10) NOT NULL,
    name        VARCHAR(50) NOT NULL,
    nationality VARCHAR(20)
);

-- Book Author List Table
CREATE TABLE IF NOT EXISTS book_author_list
(
    book_author_id INTEGER(20) NOT NULL,
    group_id       INTEGER(10) NOT NULL,
    author_id      INTEGER(10) NOT NULL,
    ordinal        INTEGER(2)  NOT NULL
);

-- Member List Table
CREATE TABLE IF NOT EXISTS members_list
(
    membership_id INTEGER(20) NOT NULL,
    name          VARCHAR(20) NOT NULL
);

-- Current (On going) Borrow Table
CREATE TABLE IF NOT EXISTS current_borrow_list
(
    borrow_id     INTEGER(30) NOT NULL,
    book_id       INTEGER(10) NOT NULL,
    membership_id INTEGER(10) NOT NULL,
    borrow_date   DATE        NOT NULL
);

-- Returned History Table
CREATE TABLE IF NOT EXISTS returned_history
(
    return_id     INTEGER(10) NOT NULL,
    book_id       INTEGER(10) NOT NULL,
    membership_id INTEGER(10) NOT NULL,
    borrow_date   DATE        NOT NULL,
    return_date   DATE        NOT NULL
);

-- Publisher List Table
CREATE TABLE IF NOT EXISTS publishers_list
(
    publisher_id   INTEGER(10) NOT NULL,
    publisher_name VARCHAR(20) NOT NULL
);

/*
 Add constraints to the table
 */


-- primary key adding in categories_list
ALTER TABLE library_database.categories_list
    ADD CONSTRAINT pk_cat_id
        PRIMARY KEY (category_id);

-- primary key adding in members_list
ALTER TABLE library_database.members_list
    ADD CONSTRAINT pk_member_id
        PRIMARY KEY (membership_id);

-- primary key adding in books_list
ALTER TABLE library_database.books_list
    ADD CONSTRAINT pk_book_id
        PRIMARY KEY (book_id);

-- primary key adding in book_group_list
ALTER TABLE library_database.book_group_list
    ADD CONSTRAINT pk_group_id
        PRIMARY KEY (group_id);

-- primary key adding in authors_list
ALTER TABLE library_database.authors_list
    ADD CONSTRAINT pk_author_id
        PRIMARY KEY (author_id);

-- primary key adding in returned_history
ALTER TABLE library_database.returned_history
    ADD CONSTRAINT pk_return_id
        PRIMARY KEY (return_id);

-- primary key adding in current_borrow_list
ALTER TABLE library_database.current_borrow_list
    ADD CONSTRAINT pk_borrow_id
        PRIMARY KEY (borrow_id);

-- primary key adding in publishers_list
ALTER TABLE library_database.publishers_list
    ADD CONSTRAINT pk_publisher_id
        PRIMARY KEY (publisher_id);

-- foreign key adding in books_List
ALTER TABLE library_database.books_list
    ADD CONSTRAINT fk_group
        FOREIGN KEY (group_id)
            REFERENCES library_database.book_group_list (group_id)
            ON DELETE CASCADE ON UPDATE CASCADE;

-- foreign key adding in book_group_List
ALTER TABLE library_database.book_group_list
    ADD CONSTRAINT fk_cat_id_books
        FOREIGN KEY (category_id)
            REFERENCES library_database.categories_list (category_id)
            ON DELETE CASCADE ON UPDATE CASCADE;

-- foreign key adding in book_group_list
ALTER TABLE library_database.book_group_list
    ADD CONSTRAINT fk_publisher_id
        FOREIGN KEY (publisher_id)
            REFERENCES library_database.publishers_list (publisher_id)
            ON DELETE CASCADE ON UPDATE CASCADE;

-- foreign key adding in book_author_list
ALTER TABLE library_database.book_author_list
    ADD CONSTRAINT fk_book_id_book_author
        FOREIGN KEY (group_id)
            REFERENCES library_database.book_group_list (group_id)
            ON DELETE CASCADE ON UPDATE CASCADE;

-- foreign key adding in book_author_list
ALTER TABLE library_database.book_author_list
    ADD CONSTRAINT fk_author_id_book_author
        FOREIGN KEY (author_id)
            REFERENCES library_database.authors_list (author_id)
            ON DELETE CASCADE ON UPDATE CASCADE;

-- primary key adding in book_author_list
ALTER TABLE library_database.book_author_list
    ADD CONSTRAINT pk_book_author_list_id
        PRIMARY KEY (book_author_id);

-- unique key constraint in book author list
ALTER TABLE library_database.book_author_list
    ADD CONSTRAINT unique_key_book_author_list
        UNIQUE KEY (group_id, author_id);

-- foreign key adding in current_borrow_list
ALTER TABLE library_database.current_borrow_list
    ADD CONSTRAINT fk_book_id_current_borrow_list
        FOREIGN KEY (book_id)
            REFERENCES library_database.books_list (book_id)
            ON DELETE CASCADE ON UPDATE CASCADE;

-- foreign key adding in current_borrow_list
ALTER TABLE library_database.current_borrow_list
    ADD CONSTRAINT fk_member_id_current_borrow_list
        FOREIGN KEY (membership_id)
            REFERENCES library_database.members_list (membership_id)
            ON DELETE CASCADE ON UPDATE CASCADE;

-- foreign key adding in returned_history
ALTER TABLE library_database.returned_history
    ADD CONSTRAINT fk_member_id_returned_history
        FOREIGN KEY (membership_id)
            REFERENCES library_database.members_list (membership_id)
            ON DELETE CASCADE ON UPDATE CASCADE;

-- foreign key adding in returned_history
ALTER TABLE library_database.returned_history
    ADD CONSTRAINT fk_book_id_returned_history
        FOREIGN KEY (book_id)
            REFERENCES library_database.books_list (book_id)
            ON DELETE CASCADE ON UPDATE CASCADE;
