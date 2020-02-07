FROM    rieicp/lamp:base

COPY    default-typo3.sql.zip /tmp/default-typo3.sql.zip
COPY    database.php /tmp/database.php
RUN     apt install -y unzip && cd /tmp && unzip default-typo3.sql.zip && rm -f default-typo3.sql.zip
CMD     service mysql start && service ssh start && service apache2 start && php /tmp/database.php && mysql -uroot -proot default-typo3 < /tmp/default-typo3.sql && /bin/bash
