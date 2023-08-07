CREATE TABLE USERS (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           username VARCHAR(255) NOT NULL UNIQUE,
                           password VARCHAR(255) NOT NULL,
                           full_name VARCHAR(255) NOT NULL,
                           email VARCHAR(255) NOT NULL UNIQUE,
                           phone VARCHAR(20) NOT NULL UNIQUE,
                           birthday DATE NOT NULL,
                           gender VARCHAR(10) NOT NULL,
                           create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                           update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                           disabled ENUM('YES', 'NO') NOT NULL DEFAULT 'NO',
                           nickname VARCHAR(255) UNIQUE,
                           profile_picture_name VARCHAR(255),
                           type ENUM('ADMIN', 'CUSTOMER', 'OWNER') NOT NULL
);

CREATE TABLE STORES (
                        id INT PRIMARY KEY AUTO_INCREMENT,
                        name VARCHAR(255) NOT NULL,
                        business_license INT NOT NULL UNIQUE,
                        address VARCHAR(255) NOT NULL,
                        category VARCHAR(50) NOT NULL,
                        zipcode INT NOT NULL,
                        latitude DOUBLE NOT NULL,
                        longitude DOUBLE NOT NULL,
                        description TEXT,
                        phone VARCHAR(20) NOT NULL UNIQUE,
                        read_count INT NOT NULL,
                        create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                        update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                        disabled ENUM('NO', 'YES') NOT NULL DEFAULT 'NO',
                        owner_id INT NOT NULL,
                        FOREIGN KEY (owner_id) REFERENCES USERS(id)
);

CREATE TABLE STORE_OPEN_TIMES (
                                  id INT PRIMARY KEY AUTO_INCREMENT,
                                  day VARCHAR(20) NOT NULL,
                                  open_time TIME NOT NULL,
                                  close_time TIME NOT NULL,
                                  store_id INT NOT NULL,
                                  FOREIGN KEY (store_id) REFERENCES STORES(id)
);

CREATE TABLE ROLES (
                            user_id INT NOT NULL,
                            role VARCHAR(50) NOT NULL,
                            PRIMARY KEY (user_id, role),
                            FOREIGN KEY (user_id) REFERENCES USERS(id)
);

CREATE TABLE REVIEWS (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         rating DOUBLE NOT NULL,
                         content TEXT NOT NULL,
                         create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         liked_count INT NOT NULL DEFAULT 0,
                         report_count INT NOT NULL DEFAULT 0,
                         disabled ENUM('NO', 'YES') NOT NULL DEFAULT 'NO',
                         blocked ENUM('NO', 'YES') NOT NULL DEFAULT 'NO',
                         customer_id INT NOT NULL,
                         store_id INT NOT NULL,
                         FOREIGN KEY (customer_id) REFERENCES USERS(id),
                         FOREIGN KEY (store_id) REFERENCES STORES(id)
);

CREATE TABLE REVIEW_COMMENTS (
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 content TEXT NOT NULL,
                                 create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                                 update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                 disabled ENUM('NO', 'YES') NOT NULL DEFAULT 'NO',
                                 review_id INT NOT NULL,
                                 owner_id INT NOT NULL,
                                 FOREIGN KEY (review_id) REFERENCES REVIEWS(id),
                                 FOREIGN KEY (owner_id) REFERENCES USERS(id)
);

CREATE TABLE REVIEW_KEYWORDS (
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 keyword VARCHAR(255) NOT NULL,
                                 review_id INT NOT NULL,
                                 FOREIGN KEY (review_id) REFERENCES REVIEWS(id)
);

CREATE TABLE REVIEW_PICTURES (
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 picture_name VARCHAR(255) NOT NULL,
                                 review_id INT NOT NULL,
                                 FOREIGN KEY (review_id) REFERENCES REVIEWS(id)
);

CREATE TABLE REVIEW_LIKES (
                              customer_id INT NOT NULL,
                              review_id INT NOT NULL,
                              PRIMARY KEY (customer_id, review_id),
                              FOREIGN KEY (customer_id) REFERENCES USERS(id),
                              FOREIGN KEY (review_id) REFERENCES REVIEWS(id)
);

CREATE TABLE REVIEW_REPORTS (
                              id INT PRIMARY KEY AUTO_INCREMENT,
                              category VARCHAR(50) NOT NULL,
                              content TEXT NOT NULL,
                              create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                              update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                              status ENUM('PENDING', 'CONFIRMED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
                              reporter_id INT,
                              admin_id INT,
                              review_id INT,
                              FOREIGN KEY (review_id) REFERENCES REVIEWS(id),
                              FOREIGN KEY (reporter_id) REFERENCES USERS(id),
                              FOREIGN KEY (admin_id) REFERENCES USERS(id)
);

CREATE TABLE REVIEW_REPORT_CATEGORIES (
                                        id INT PRIMARY KEY AUTO_INCREMENT,
                                        category VARCHAR(50) NOT NULL,
                                        report_id INT NOT NULL,
                                        FOREIGN KEY (report_id) REFERENCES REVIEW_REPORTS(id)
);

CREATE TABLE POSTS (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       title VARCHAR(255) NOT NULL,
                       content TEXT NOT NULL,
                       create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                       update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                       customer_id INT NOT NULL,
                       store_id INT NOT NULL,
                       report_count INT DEFAULT 0,
                       liked_count INT DEFAULT 0,
                       disabled ENUM('NO', 'YES') NOT NULL DEFAULT 'NO',
                       blocked ENUM('NO', 'YES') NOT NULL DEFAULT 'NO',
                       FOREIGN KEY (customer_id) REFERENCES USERS(id),
                       FOREIGN KEY (customer_id) REFERENCES STORES(id)
);

CREATE TABLE POST_COMMENTS (
                               id INT PRIMARY KEY AUTO_INCREMENT,
                               content TEXT NOT NULL,
                               disabled ENUM('NO', 'YES') NOT NULL DEFAULT 'NO',
                               create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                               update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                               post_id INT NOT NULL,
                               customer_id INT NOT NULL,
                               FOREIGN KEY (post_id) REFERENCES POSTS(id),
                               FOREIGN KEY (customer_id) REFERENCES USERS(id)
);

CREATE TABLE POST_PICTURES (
                               id INT PRIMARY KEY AUTO_INCREMENT,
                               picture_name VARCHAR(255) NOT NULL,
                               post_id INT NOT NULL,
                               FOREIGN KEY (post_id) REFERENCES POSTS(id)
);

CREATE TABLE POST_REPORTS (
                         id INT PRIMARY KEY AUTO_INCREMENT,
                         category VARCHAR(50) NOT NULL,
                         content TEXT NOT NULL,
                         create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         update_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                         status ENUM('PENDING', 'CONFIRMED', 'REJECTED') NOT NULL DEFAULT 'PENDING',
                         reporter_id INT,
                         post_id INT,
                         admin_id INT,
                         FOREIGN KEY (reporter_id) REFERENCES USERS(id),
                         FOREIGN KEY (post_id) REFERENCES POSTS(id),
                         FOREIGN KEY (admin_id) REFERENCES USERS(id)
);

CREATE TABLE POST_REPORT_CATEGORIES (
                                   id INT PRIMARY KEY AUTO_INCREMENT,
                                   category VARCHAR(50) NOT NULL,
                                   report_id INT NOT NULL,
                                   FOREIGN KEY (report_id) REFERENCES POST_REPORTS(id)
);

CREATE TABLE POST_LIKES (
                            customer_id INT NOT NULL,
                            post_id INT NOT NULL,
                            PRIMARY KEY (customer_id, post_id),
                            FOREIGN KEY (customer_id) REFERENCES USERS(id),
                            FOREIGN KEY (post_id) REFERENCES POSTS(id)
);

CREATE TABLE OTP (
                      id INT PRIMARY KEY AUTO_INCREMENT,
                      email VARCHAR(255) NOT NULL,
                      otp_code VARCHAR(10) NOT NULL,
                      create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                      FOREIGN KEY (email) REFERENCES USERS(email)
);

CREATE TABLE FOODS (
                       id INT PRIMARY KEY AUTO_INCREMENT,
                       name VARCHAR(255) NOT NULL,
                       price INT NOT NULL,
                       store_id INT NOT NULL,
                       FOREIGN KEY (store_id) REFERENCES STORES(id)
);

CREATE TABLE FOLLOWS (
                         follower_id INT NOT NULL,
                         followed_id INT NOT NULL,
                         create_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                         PRIMARY KEY (follower_id, followed_id),
                         FOREIGN KEY (follower_id) REFERENCES USERS(id),
                         FOREIGN KEY (followed_id) REFERENCES USERS(id)
);

CREATE TABLE FOLLOW_REQUESTS (
                                 id INT PRIMARY KEY AUTO_INCREMENT,
                                 sender_id INT NOT NULL,
                                 recipient_id INT NOT NULL,
                                 status ENUM('PENDING', 'ACCEPTED', 'DECLINED') NOT NULL DEFAULT 'PENDING',
                                 FOREIGN KEY (sender_id) REFERENCES USERS(id),
                                 FOREIGN KEY (recipient_id) REFERENCES USERS(id)
);

CREATE TABLE BOOKMARKS (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           store_id INT NOT NULL,
                           customer_id INT NOT NULL,
                           createDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
                           FOREIGN KEY (store_id) REFERENCES STORES(id),
                           FOREIGN KEY (customer_id) REFERENCES USERS(id)
);

CREATE TABLE ADVERTISES (
                            id INT PRIMARY KEY AUTO_INCREMENT,
                            store_id INT NOT NULL,
                            subscribed VARCHAR(50) NOT NULL,
                            succeeded VARCHAR(50) NOT NULL,
                            challenge_start_date DATE,
                            challenge_end_date DATE,
                            succeeded_start_date DATE,
                            succeeded_end_date DATE,
                            disabled VARCHAR(5) NOT NULL,
                            FOREIGN KEY (store_id) REFERENCES STORES(id)
);
