FROM rieicp/lamp

COPY database.php /tmp/database.php
RUN service mysql start && service ssh start && service apache2 start && php /tmp/database.php
CMD /bin/bash
