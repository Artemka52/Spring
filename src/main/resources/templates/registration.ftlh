<#import "blocks/template.ftlh" as t>
<@t.template user>
    <style>
        :root {
                --text-gray: #6c757d;
        }

        .registration-container {
            max-width: 500px;
            margin: 2rem auto;
            padding: 2rem;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }

        .registration-title {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 1.5rem;
            font-size: 2.2em;
            font-weight: 600;
        }

        .registration-form hr {
            margin: 1.5rem 0;
            border-color: #eee;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            color: #34495e;
            font-weight: 500;
        }

        .form-control {
            width: 100%;
            padding: 0.8rem 1rem;
            border: 2px solid #e0e0e0;
            border-radius: 6px;
            font-size: 1em;
            transition: border-color 0.3s ease;
        }

        .form-control:focus {
            outline: none;
            border-color: #3498db;
            box-shadow: 0 0 0 3px rgba(52,152,219,0.1);
        }

        .btn-submit {
            width: 100%;
            padding: 1rem;
            background: var(--text-gray);;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-submit:hover {
            background: #5a6268;
            transform: translateY(-1px);
        }

        .btn-submit:active {
            background: #495057;
            transform: translateY(0);
        }

        .error-message {
            margin-top: 1.5rem;
            padding: 1rem;
            background: #fee;
            border: 1px solid #ff3860;
            border-radius: 6px;
            color: #ff3860;
            text-align: center;
            font-size: 1em;
        }

        @media (max-width: 576px) {
            .registration-container {
                margin: 1rem;
                padding: 1.5rem;
            }

            .registration-title {
                font-size: 1.8em;
            }
        }
    </style>

    <div class="registration-container">
        <h1 class="registration-title">Регистрация</h1>
        <hr>
        <form class="registration-form" action="/registration" method="post">
            <div class="form-group">
                <label for="name">Имя пользователя</label>
                <input type="text" class="form-control" required id="name" name="name" placeholder="Введите ваше имя">
            </div>
            <div class="form-group">
                <label for="email">Электронная почта</label>
                <input type="email" class="form-control" id="email" required name="email" placeholder="example@mail.ru">
            </div>
            <div class="form-group">
                <label for="phoneNumber">Номер телефона</label>
                <input type="text" class="form-control" id="phoneNumber" required name="phoneNumber" placeholder="+7 (999) 999-99-99">
            </div>
            <div class="form-group">
                <label for="password">Пароль</label>
                <input type="password" class="form-control" id="password" required name="password" placeholder="Не менее 8 символов">
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="btn-submit">Зарегистрироваться</button>
        </form>
        <#if errorMessage??>
            <div class="error-message">${errorMessage}</div>
        </#if>
    </div>
</@t.template>