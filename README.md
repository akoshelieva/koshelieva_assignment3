# koshelieva_assignment3

### Завдання 1:Dirty Read – READ UNCOMMITTED
#### Сценарій
  - <img width="701" alt="image" src="https://github.com/user-attachments/assets/9c1aaae6-3319-448f-80d9-924e21f4c404" />
  - Початкове значення `runtime = 100` для `type = "SHOW"` і `release_year = 1945` 
  - <img width="703" alt="image" src="https://github.com/user-attachments/assets/9e7f7b2e-9c0b-4360-87e6-5b8663436cb2" />
  - Після `UPDATE`: `runtime = 80` в першій транзакції (незафіксовано).
  - <img width="740" alt="image" src="https://github.com/user-attachments/assets/9e222f80-10f5-4956-92fa-e804dccfd614" />
  - Читання: `runtime = 80` в другій транзакції (брудне читання).
  - <img width="735" alt="image" src="https://github.com/user-attachments/assets/3476850e-56dd-4144-8b7d-60071c3c7484" />
  - Відкат Транзакції 1: `runtime = 100`.

#### Пояснення
- **Що спричинило аномалію?**
  - Аномалія "брудне читання" виникла, тому що Транзакція 2 зчитала дані, змінені Транзакцією 1, до їхньої фіксації. Подальший `ROLLBACK` у Транзакції 1 зробив ці дані недійсними.
- **Чому рівень ізоляції це дозволяє?**
  - Рівень `READ UNCOMMITTED` дозволяє транзакціям зчитувати незафіксовані ("брудні") зміни для підвищення паралелізму, жертвуючи цілісністю даних. Це призводить до некоректного зчитування, якщо модифікуюча транзакція відкотиться.

#### Термінологія
- **Брудне читання**: Зчитування незафіксованих даних.
- **Фіксація**: Дія `COMMIT` або `ROLLBACK`, яка завершує транзакцію.
- **Транзакція**: Послідовність операцій, яка розглядається як єдина одиниця.
- **Паралелізм**: Одночасне виконання Транзакції 1 і Транзакції 2.

---

### Завдання 2: Non-Repeatable Read – READ COMMITTED
#### Сценарій

  - <img width="747" alt="image" src="https://github.com/user-attachments/assets/831ecea7-8f9e-43f5-81e4-e711b8150f92" />
  - Перше зчитування: `description = "A mentally unstable Vietnam War veteran works as a night-time taxi driver in New York City where the perceived decadence and sleaze feed his urge fo..."`.
  - <img width="694" alt="image" src="https://github.com/user-attachments/assets/5a4e7420-dc40-4c63-b2ac-3f31d280b3fb" />
  - Після `UPDATE` і `COMMIT`в другій транзакції застосована: Зміна `description` застосована.
  - <img width="706" alt="image" src="https://github.com/user-attachments/assets/8508527c-e26a-436a-802d-e6c95bbc6051"/>
  - Друге зчитування: `description = "This collection includes 12 World War II-era propaganda films"`.
#### Пояснення
- **Концепція**:
  - Неповторне читання виникає, коли Транзакція 1 зчитує один і той самий рядок двічі, а між цими зчитуваннями Транзакція 2 змінює дані й фіксує їх. Рівень `READ COMMITTED` забезпечує, що зчитуються лише зафіксовані дані на момент зчитування, але не запобігає оновленням від інших транзакцій.
- **Спостережувані результати**:
  - Перше зчитування повернуло початковий опис до оновлення Транзакцією 2.
  - Друге зчитування показало оновлений опис після `COMMIT` Транзакції 2, що демонструє нестабільність даних у межах однієї транзакції.
- **Що спричинило аномалію?**
  - Аномалія виникла через оновлення Транзакцією 2 і її фіксацію між двома зчитуваннями Транзакції 1.
- **Чому рівень ізоляції це дозволяє?**
  - `READ COMMITTED` дозволяє видимість зафіксованих змін між зчитуваннями для підтримки паралелізму, що призводить до неповторного читання.

#### Термінологія
- **Неповторне читання**: Зчитування одного рядка з різними результатами через проміжні оновлення.
- **Фіксація**: Дія `COMMIT`, яка завершує зміни Транзакції 2.
- **Транзакція**: Послідовність операцій (наприклад, `SELECT` і `UPDATE`).
- **Паралелізм**: Одночасне виконання Транзакції 1 і Транзакції 2.

# Завдання 3: Repeatable Read – REPEATABLE READ

- <img width="671" alt="image" src="https://github.com/user-attachments/assets/c0994c94-373a-444c-8f5f-3133b25512e0" />
- Транзакція 1 читає опис фільму.
- <img width="652" alt="image" src="https://github.com/user-attachments/assets/4bce8928-80b5-4c77-b4fd-e96ee85e1c74" />
- Транзакція 2 змінює опис того самого фільму й робить `COMMIT`.
- <img width="514" alt="image" src="https://github.com/user-attachments/assets/fcde71bc-376c-4bfb-83a9-bf6f9656abd0"/>
- Перевірка змін
- <img width="685" alt="image" src="https://github.com/user-attachments/assets/fc618e56-fa8f-43b7-963a-9d0535fbf31e" />
- Транзакція 1 повторно читає той самий запис — і отримує **старе значення**, незважаючи на зміну.

## - **Концепція**:
- Транзакція 1 **двічі читає одне й те саме значення**, незважаючи на зміну з боку транзакції 2.
- Це підтверджує, що `REPEATABLE READ` блокує **аномалію неповторного читання** — значення залишаються фіксованими на момент першого звернення в межах транзакції.

Рівень ізоляції **`REPEATABLE READ`** гарантує, що **усі читання одного і того ж рядка протягом транзакції будуть консистентними**. Зміни, зроблені іншими транзакціями, не впливають на результат повторного читання в межах цієї транзакції.

**Завдання 4:Порівняння read committed i repeatable read**
Порівняння **Read Committed** і **Repeatable Read**:

**Перечитування одного й того ж рядка:**
- У **Read Committed** дані можуть бути змінені, якщо інша транзакція внесе оновлення та завершить їх фіксацію, що призводить до різного відображення інформації в межах однієї транзакції.
- У **Repeatable Read** значення залишається стабільним протягом усієї транзакції, навіть якщо інші транзакції внесуть зміни та зафіксують їх.

**Доступність оновлених зафіксованих даних:**
- У **Read Committed** поточна транзакція бачить усі зміни, які були зафіксовані іншими транзакціями під час її виконання.
- У **Repeatable Read** нові зафіксовані оновлення від інших транзакцій стають видимими лише після завершення поточної транзакції.

**Запобігання non-repeatable read:**
- **Read Committed** не захищає від цього явища — повторні запити можуть повертати різні дані.
- **Repeatable Read** забезпечує послідовність — результат одного й того ж запиту залишається незмінним протягом усього процесу транзакції.



