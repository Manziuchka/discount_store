# README

 Ruby: функция Checkout

Функция Checkout для магазина, которая считатет общую стоимость покупки с учетом скидок и акций.

Основные функции:
* API для создания и редактирование товаров - ProductsController
* API для создания и редактирование акций - DiscountController
* Подсчет общей стоимости покупки - class Checkout

На входе подается список кодов товаров (например: CC PC WA).
На выходе класс Checkout считает сумму покупки с учетом акций и скидок.

* Ruby version 2.6.2 Rails version 5.2.3

* Database PostgreSQL
