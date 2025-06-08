# koshelieva_assignment3
Dirty Read – READ UNCOMMITTED
<img width="701" alt="image" src="https://github.com/user-attachments/assets/9c1aaae6-3319-448f-80d9-924e21f4c404" /> показуємо що маємо попередній стан
<img width="703" alt="image" src="https://github.com/user-attachments/assets/9e7f7b2e-9c0b-4360-87e6-5b8663436cb2" /> апдейт

<img width="740" alt="image" src="https://github.com/user-attachments/assets/9e222f80-10f5-4956-92fa-e804dccfd614" /> транзакція 2 читає зміни
<img width="735" alt="image" src="https://github.com/user-attachments/assets/3476850e-56dd-4144-8b7d-60071c3c7484" /> транзакція 1 післа ролбеку
Non-Repeatable Read – READ COMMITTED
<img width="747" alt="image" src="https://github.com/user-attachments/assets/831ecea7-8f9e-43f5-81e4-e711b8150f92" /> транзакція 1 читає дані
<img width="694" alt="image" src="https://github.com/user-attachments/assets/5a4e7420-dc40-4c63-b2ac-3f31d280b3fb" /> транзакція 2 змінує і комітить
<img width="706" alt="image" src="https://github.com/user-attachments/assets/8508527c-e26a-436a-802d-e6c95bbc6051" /> транзакція 1 знову читає дані і вони відрізняються
Repeatable Read – REPEATABLE READ
<img width="671" alt="image" src="https://github.com/user-attachments/assets/c0994c94-373a-444c-8f5f-3133b25512e0" /> транзакція 1 читає дані
<img width="652" alt="image" src="https://github.com/user-attachments/assets/4bce8928-80b5-4c77-b4fd-e96ee85e1c74" /> транзакція 2 змінює дані і комітить
<img width="514" alt="image" src="https://github.com/user-attachments/assets/fcde71bc-376c-4bfb-83a9-bf6f9656abd0" /> показуємо що в 2 транзакції зміни є
<img width="685" alt="image" src="https://github.com/user-attachments/assets/fc618e56-fa8f-43b7-963a-9d0535fbf31e" /> в першій транзакції показуємо що значення те саме
Порівняння read committed i repeatable read












