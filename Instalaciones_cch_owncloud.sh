# Añade el repositorio PPA de PHP de ondrej/php
echo -e "\e[32mAñadiendo el repositorio de PHP\e[0m"
sudo add-apt-repository ppa:ondrej/php

# Actualiza la lista de paquetes
echo -e "\e[34mActualizando la lista de paquetes\e[0m"
sudo apt update
sudo apt-get update

# Instala versiones específicas de PHP 7.3 y extensiones necesarias
echo -e "\e[31mInstalando PHP 7.3 y extensiones necesarias\e[0m"
sudo apt-get install php7.3 php7.3-mcrypt php7.3-xml php7.3-gd php7.3-opcache php7.3-mbstring

# Instala extensiones de MySQL específicamente para PHP 7.3
echo -e "\e[32mInstalando extensiones de MySQL para PHP 7.3\e[0m"
sudo apt-get install php7.3-mysql

# Instala otras extensiones PHP específicas para PHP 7.3
echo -e "\e[34mInstalando otras extensiones de PHP 7.3 necesarias para OwnCloud\e[0m"
sudo apt-get install php7.3-zip php7.3-intl php7.3-curl

# instala unzip
echo -e "\e[31mInstalando unzip\e[0m"
sudo apt-get install unzip

# Descarga el instalador de Composer y lo ejecuta
echo -e "\e[32mDescargando e instalando Composer\e[0m"
curl -sS https://getcomposer.org/installer | php

# Descarga la última versión estable de ownCloud
echo -e "\e[34mDescargando ownCloud\e[0m"
wget https://download.owncloud.com/server/stable/owncloud-10.4.1.zip

# Descomprime el archivo descargado de ownCloud
echo -e "\e[31mDescomprimiendo ownCloud\e[0m"
unzip ./owncloud-10.4.1.zip 

# Mueve el directorio de ownCloud al directorio web del servidor
echo -e "\e[32mMoviendo ownCloud al directorio del servidor web\e[0m"
sudo mv owncloud /var/www/

# Mueve composer.phar al directorio binario local para su uso global
echo -e "\e[34mInstalando Composer globalmente\e[0m"
sudo mv composer.phar /usr/local/bin/composer

# Mueve la configuración de Apache para Laravel
echo -e "\e[31mConfigurando Apache para Laravel\e[0m"
sudo cp ./laravel.conf /etc/apache2/sites-available/
sudo a2dissite 000-default.conf && sudo a2ensite laravel.conf && sudo a2enmod rewrite

# Verifica la instalación de extensiones de MySQL en PHP 7.3
echo -e "\e[32mVerificando la instalación de MySQL en PHP 7.3\e[0m"
php -m | grep mysql

# Crea un directorio para tu aplicación
echo -e "\e[34mCreando directorio para la aplicación\e[0m"
sudo mkdir /var/www/html/cch

# Clona el repositorio de backend de CCH
echo -e "\e[31mClonando el repositorio de CCH Backend\e[0m"
sudo git clone https://github.com/emaginacion/CCHBackend.git

# Mueve el repositorio clonado al directorio API
echo -e "\e[32mMoviendo el backend de CCH al directorio API\e[0m"
sudo mv ./CCHBackend /var/www/html/cch/api

# Cambia al directorio API
echo -e "\e[34mCambiando al directorio API\e[0m"
cd /var/www/html/cch/api

# Instala dependencias con Composer
echo -e "\e[31mInstalando dependencias con Composer\e[0m"
sudo composer install

# Reinicia apache
echo -e "\e[32mReiniciando Apache\e[0m"
sudo service apache2 restart

# Reinicia apache
echo -e "\e[32mReiniciando Apache\e[0m"
sudo find /var/www/html/cch/api/public -type d -exec chmod 755 {} \;
sudo find /var/www/html/cch/api/public -type f -exec chmod 644 {} \;
sudo find /var/www/html/cch/api/storage -type d -exec chmod 775 {} \;
sudo find /var/www/html/cch/api/storage -type f -exec chmod 664 {} \;
sudo chown -R www-data:www-data /var/www/html/cch/api/storage
