BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "accounts_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	"name"	varchar(60) NOT NULL,
	"bio"	text NOT NULL,
	"image"	varchar(200),
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "accounts_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	bigint NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "accounts_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	bigint NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "accounts_user_followers" (
	"id"	integer NOT NULL,
	"from_user_id"	bigint NOT NULL,
	"to_user_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("to_user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("from_user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	bigint NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "taggit_tag" (
	"id"	integer NOT NULL,
	"name"	varchar(100) NOT NULL UNIQUE,
	"slug"	varchar(100) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "taggit_taggeditem" (
	"id"	integer NOT NULL,
	"object_id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"tag_id"	integer NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("tag_id") REFERENCES "taggit_tag"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "articles_article" (
	"id"	integer NOT NULL,
	"title"	varchar(120) NOT NULL,
	"summary"	text NOT NULL,
	"content"	text NOT NULL,
	"created"	datetime NOT NULL,
	"updated"	datetime NOT NULL,
	"author_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("author_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "articles_article_favorites" (
	"id"	integer NOT NULL,
	"article_id"	bigint NOT NULL,
	"user_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("user_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("article_id") REFERENCES "articles_article"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "comments_comment" (
	"id"	integer NOT NULL,
	"content"	text NOT NULL,
	"created"	datetime NOT NULL,
	"updated"	datetime NOT NULL,
	"article_id"	bigint NOT NULL,
	"author_id"	bigint NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT),
	FOREIGN KEY("article_id") REFERENCES "articles_article"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("author_id") REFERENCES "accounts_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
INSERT INTO "django_migrations" VALUES (1,'contenttypes','0001_initial','2022-10-23 19:26:49.952304');
INSERT INTO "django_migrations" VALUES (2,'contenttypes','0002_remove_content_type_name','2022-10-23 19:26:50.074968');
INSERT INTO "django_migrations" VALUES (3,'auth','0001_initial','2022-10-23 19:26:50.338114');
INSERT INTO "django_migrations" VALUES (4,'auth','0002_alter_permission_name_max_length','2022-10-23 19:26:50.439053');
INSERT INTO "django_migrations" VALUES (5,'auth','0003_alter_user_email_max_length','2022-10-23 19:26:50.552076');
INSERT INTO "django_migrations" VALUES (6,'auth','0004_alter_user_username_opts','2022-10-23 19:26:50.644161');
INSERT INTO "django_migrations" VALUES (7,'auth','0005_alter_user_last_login_null','2022-10-23 19:26:50.752266');
INSERT INTO "django_migrations" VALUES (8,'auth','0006_require_contenttypes_0002','2022-10-23 19:26:50.840221');
INSERT INTO "django_migrations" VALUES (9,'auth','0007_alter_validators_add_error_messages','2022-10-23 19:26:50.951142');
INSERT INTO "django_migrations" VALUES (10,'auth','0008_alter_user_username_max_length','2022-10-23 19:26:51.045086');
INSERT INTO "django_migrations" VALUES (11,'auth','0009_alter_user_last_name_max_length','2022-10-23 19:26:51.153019');
INSERT INTO "django_migrations" VALUES (12,'auth','0010_alter_group_name_max_length','2022-10-23 19:26:51.245961');
INSERT INTO "django_migrations" VALUES (13,'auth','0011_update_proxy_permissions','2022-10-23 19:26:51.367886');
INSERT INTO "django_migrations" VALUES (14,'auth','0012_alter_user_first_name_max_length','2022-10-23 19:26:51.486301');
INSERT INTO "django_migrations" VALUES (15,'accounts','0001_initial','2022-10-23 19:26:51.753932');
INSERT INTO "django_migrations" VALUES (16,'accounts','0002_alter_user_managers_user_followers','2022-10-23 19:26:51.979123');
INSERT INTO "django_migrations" VALUES (17,'admin','0001_initial','2022-10-23 19:26:52.195297');
INSERT INTO "django_migrations" VALUES (18,'admin','0002_logentry_remove_auto_add','2022-10-23 19:26:52.292914');
INSERT INTO "django_migrations" VALUES (19,'admin','0003_logentry_add_action_flag_choices','2022-10-23 19:26:52.427093');
INSERT INTO "django_migrations" VALUES (20,'taggit','0001_initial','2022-10-23 19:26:52.721049');
INSERT INTO "django_migrations" VALUES (21,'taggit','0002_auto_20150616_2121','2022-10-23 19:26:52.836058');
INSERT INTO "django_migrations" VALUES (22,'taggit','0003_taggeditem_add_unique_index','2022-10-23 19:26:52.959134');
INSERT INTO "django_migrations" VALUES (23,'taggit','0004_alter_taggeditem_content_type_alter_taggeditem_tag','2022-10-23 19:26:53.080136');
INSERT INTO "django_migrations" VALUES (24,'articles','0001_initial','2022-10-23 19:26:53.295646');
INSERT INTO "django_migrations" VALUES (25,'articles','0002_article_favorites_alter_article_tags','2022-10-23 19:26:53.544851');
INSERT INTO "django_migrations" VALUES (26,'comments','0001_initial','2022-10-23 19:26:53.779131');
INSERT INTO "django_migrations" VALUES (27,'sessions','0001_initial','2022-10-23 19:26:53.987035');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (5,'sessions','session');
INSERT INTO "django_content_type" VALUES (6,'taggit','tag');
INSERT INTO "django_content_type" VALUES (7,'taggit','taggeditem');
INSERT INTO "django_content_type" VALUES (8,'accounts','user');
INSERT INTO "django_content_type" VALUES (9,'articles','article');
INSERT INTO "django_content_type" VALUES (10,'comments','comment');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (14,4,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (15,4,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (16,4,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (17,5,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (18,5,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (19,5,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (20,5,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (21,6,'add_tag','Can add tag');
INSERT INTO "auth_permission" VALUES (22,6,'change_tag','Can change tag');
INSERT INTO "auth_permission" VALUES (23,6,'delete_tag','Can delete tag');
INSERT INTO "auth_permission" VALUES (24,6,'view_tag','Can view tag');
INSERT INTO "auth_permission" VALUES (25,7,'add_taggeditem','Can add tagged item');
INSERT INTO "auth_permission" VALUES (26,7,'change_taggeditem','Can change tagged item');
INSERT INTO "auth_permission" VALUES (27,7,'delete_taggeditem','Can delete tagged item');
INSERT INTO "auth_permission" VALUES (28,7,'view_taggeditem','Can view tagged item');
INSERT INTO "auth_permission" VALUES (29,8,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (30,8,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (31,8,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (32,8,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (33,9,'add_article','Can add article');
INSERT INTO "auth_permission" VALUES (34,9,'change_article','Can change article');
INSERT INTO "auth_permission" VALUES (35,9,'delete_article','Can delete article');
INSERT INTO "auth_permission" VALUES (36,9,'view_article','Can view article');
INSERT INTO "auth_permission" VALUES (37,10,'add_comment','Can add comment');
INSERT INTO "auth_permission" VALUES (38,10,'change_comment','Can change comment');
INSERT INTO "auth_permission" VALUES (39,10,'delete_comment','Can delete comment');
INSERT INTO "auth_permission" VALUES (40,10,'view_comment','Can view comment');
INSERT INTO "accounts_user" VALUES (1,'pbkdf2_sha256$320000$wigxGvD9Lgea8PNKR0Q0MF$kojuOEnHZFEur+BPgtZjREOewpe8QqxP60Hqz5cnzdU=','2022-10-23 19:50:45.638416',0,0,1,'2022-10-23 19:31:42.743337','dav2099@gmail.com','Dmitry','Infocommunications and digital media','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNGirlcD6-Py-T1twr1UpIJ4yL1ywRmPM69gfA3YeN4UmmuM4cU8cEIx0ank7Az1vA9q8&usqp=CAU');
INSERT INTO "accounts_user" VALUES (2,'pbkdf2_sha256$320000$wUwnUKAwayVnwDu6ia8G5J$dVVtBdJ3ZuxaOit1VJl78pFnycqZrpI7oC+bGn4+b8Q=','2022-10-23 19:49:07.702710',0,0,1,'2022-10-23 19:49:07.223857','student@niuitmo.ru','RandomStudent','','https://isu.ifmo.ru/i/libraries/frontend/logo/isu.png');
INSERT INTO "accounts_user_followers" VALUES (3,2,1);
INSERT INTO "accounts_user_followers" VALUES (4,1,2);
INSERT INTO "taggit_tag" VALUES (1,'Cute','cute');
INSERT INTO "taggit_tag" VALUES (2,'Nothing','nothing');
INSERT INTO "taggit_tag" VALUES (3,'Random','random');
INSERT INTO "taggit_tag" VALUES (4,'Whois','whois');
INSERT INTO "taggit_taggeditem" VALUES (1,1,9,1);
INSERT INTO "taggit_taggeditem" VALUES (2,2,9,2);
INSERT INTO "taggit_taggeditem" VALUES (3,3,9,3);
INSERT INTO "taggit_taggeditem" VALUES (4,3,9,4);
INSERT INTO "articles_article" VALUES (1,'Home','Letter','About nothing','2022-10-23 19:39:07.037134','2022-10-23 19:39:07.037134',1);
INSERT INTO "articles_article" VALUES (2,'Proin sed libero enim sed','Cursus euismod quis viverra nibh cras pulvinar mattis nunc sed','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Viverra maecenas accumsan lacus vel facilisis. Mauris pharetra et ultrices neque ornare. Ultrices neque ornare aenean euismod elementum nisi. Porttitor massa id neque aliquam vestibulum. Sed tempus urna et pharetra pharetra massa massa ultricies mi. Parturient montes nascetur ridiculus mus mauris. Fringilla ut morbi tincidunt augue interdum. Urna et pharetra pharetra massa massa ultricies mi quis hendrerit. Orci eu lobortis elementum nibh tellus molestie.

Lacus sed turpis tincidunt id. Cursus euismod quis viverra nibh cras pulvinar mattis nunc sed. Amet mauris commodo quis imperdiet massa tincidunt. Urna et pharetra pharetra massa massa ultricies mi quis hendrerit. Sit amet purus gravida quis blandit turpis cursus in hac. Pellentesque dignissim enim sit amet. Rhoncus aenean vel elit scelerisque mauris pellentesque pulvinar pellentesque. Amet nulla facilisi morbi tempus iaculis urna id volutpat. Fusce id velit ut tortor. Netus et malesuada fames ac turpis. Nibh tortor id aliquet lectus proin.','2022-10-23 19:41:11.996621','2022-10-23 19:41:11.996621',1);
INSERT INTO "articles_article" VALUES (3,'Nullam vehicula ipsum a arcu cursus vitae congue','Egestas integer eget aliquet nibh praesent tristique magna','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Vel eros donec ac odio tempor orci. Elementum pulvinar etiam non quam lacus. Consequat id porta nibh venenatis. Pulvinar etiam non quam lacus suspendisse faucibus interdum posuere. Purus viverra accumsan in nisl nisi. Nisl pretium fusce id velit ut tortor pretium. Mauris commodo quis imperdiet massa tincidunt nunc pulvinar sapien. Turpis egestas pretium aenean pharetra magna ac. Tellus cras adipiscing enim eu turpis egestas pretium aenean pharetra. Est placerat in egestas erat imperdiet sed euismod nisi.

Nullam vehicula ipsum a arcu cursus vitae congue. At erat pellentesque adipiscing commodo elit. Eget nunc lobortis mattis aliquam. Est velit egestas dui id ornare. Tellus integer feugiat scelerisque varius morbi enim. Cras pulvinar mattis nunc sed blandit libero. Egestas integer eget aliquet nibh praesent tristique magna. Sollicitudin aliquam ultrices sagittis orci a scelerisque. At imperdiet dui accumsan sit amet nulla facilisi morbi. Volutpat sed cras ornare arcu dui vivamus arcu felis. Egestas dui id ornare arcu odio ut sem nulla. Posuere urna nec tincidunt praesent semper feugiat nibh. Molestie at elementum eu facilisis sed odio morbi quis commodo. Sed turpis tincidunt id aliquet risus feugiat in ante metus. At quis risus sed vulputate odio. Netus et malesuada fames ac turpis egestas integer eget aliquet. Morbi quis commodo odio aenean sed adipiscing diam donec adipiscing. Pellentesque dignissim enim sit amet venenatis urna cursus eget nunc.

Donec ac odio tempor orci dapibus ultrices in iaculis. Consectetur libero id faucibus nisl. Egestas dui id ornare arcu odio ut sem nulla pharetra. Purus semper eget duis at tellus at urna condimentum. Auctor elit sed vulputate mi sit amet. Mattis enim ut tellus elementum sagittis vitae et. Faucibus scelerisque eleifend donec pretium vulputate sapien nec sagittis aliquam. Tristique sollicitudin nibh sit amet commodo nulla facilisi nullam. Maecenas sed enim ut sem viverra aliquet. Adipiscing vitae proin sagittis nisl rhoncus. Facilisi etiam dignissim diam quis enim lobortis scelerisque fermentum. Faucibus a pellentesque sit amet porttitor eget dolor. Viverra mauris in aliquam sem fringilla ut. Vitae congue eu consequat ac. Mattis vulputate enim nulla aliquet porttitor lacus. Elementum pulvinar etiam non quam lacus suspendisse faucibus interdum posuere. Leo in vitae turpis massa sed elementum tempus. Ipsum suspendisse ultrices gravida dictum fusce ut.','2022-10-23 19:50:27.205068','2022-10-23 19:50:27.205068',2);
INSERT INTO "articles_article" VALUES (14,'Random','','','2022-10-23 22:09:20.821488','2022-10-23 22:09:20.821488',1);
INSERT INTO "articles_article_favorites" VALUES (2,3,1);
INSERT INTO "comments_comment" VALUES (1,'Awesome article!','2022-10-23 21:33:40.448299','2022-10-23 21:33:46.229490',3,1);
INSERT INTO "django_session" VALUES ('xf0ulyampjbslta5jbgkn8afwh7n0fhi','.eJxVjDsOwjAQBe_iGlnx31DScwZr17vGAeRIcVIh7k4ipYB2Zt57iwTrUtPaeU4jiYtQ4vTLEPKT2y7oAe0-yTy1ZR5R7ok8bJe3ifh1Pdq_gwq9bmvUFM_FIxANMRQko4MtzgbITD6zDawcKSRr2EDIG7N-MBydjsjZic8XExQ4-Q:1omgzd:bieKBxaLkZtPq1NwWnF_cuVETQb9MFwdEuuakllj8Lw','2022-11-06 19:50:45.756344');
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "accounts_user_groups_user_id_group_id_59c0b32f_uniq" ON "accounts_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_groups_user_id_52b62117" ON "accounts_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_groups_group_id_bd11a704" ON "accounts_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "accounts_user_user_permissions_user_id_permission_id_2ab516c2_uniq" ON "accounts_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_user_permissions_user_id_e4f0a161" ON "accounts_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_user_permissions_permission_id_113bb443" ON "accounts_user_user_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "accounts_user_followers_from_user_id_to_user_id_ad929616_uniq" ON "accounts_user_followers" (
	"from_user_id",
	"to_user_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_followers_from_user_id_1e8ec42b" ON "accounts_user_followers" (
	"from_user_id"
);
CREATE INDEX IF NOT EXISTS "accounts_user_followers_to_user_id_6dddd47f" ON "accounts_user_followers" (
	"to_user_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "taggit_taggeditem_object_id_e2d7d1df" ON "taggit_taggeditem" (
	"object_id"
);
CREATE INDEX IF NOT EXISTS "taggit_taggeditem_content_type_id_9957a03c" ON "taggit_taggeditem" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "taggit_taggeditem_tag_id_f4f5b767" ON "taggit_taggeditem" (
	"tag_id"
);
CREATE INDEX IF NOT EXISTS "taggit_taggeditem_content_type_id_object_id_196cc965_idx" ON "taggit_taggeditem" (
	"content_type_id",
	"object_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "taggit_taggeditem_content_type_id_object_id_tag_id_4bb97a8e_uniq" ON "taggit_taggeditem" (
	"content_type_id",
	"object_id",
	"tag_id"
);
CREATE INDEX IF NOT EXISTS "articles_article_author_id_059aea7d" ON "articles_article" (
	"author_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "articles_article_favorites_article_id_user_id_9fdf337b_uniq" ON "articles_article_favorites" (
	"article_id",
	"user_id"
);
CREATE INDEX IF NOT EXISTS "articles_article_favorites_article_id_47bc15be" ON "articles_article_favorites" (
	"article_id"
);
CREATE INDEX IF NOT EXISTS "articles_article_favorites_user_id_9cf07a46" ON "articles_article_favorites" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "comments_comment_article_id_94fe60a2" ON "comments_comment" (
	"article_id"
);
CREATE INDEX IF NOT EXISTS "comments_comment_author_id_334ce9e2" ON "comments_comment" (
	"author_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
COMMIT;
