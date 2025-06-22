<#import "blocks/template.ftlh" as t>
<@t.template user>
    <style>
        .login-container {
            max-width: 500px;
            margin: 2rem auto;
            padding: 2rem;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }

        .login-title {
            text-align: center;
            color: #2c3e50;
            margin-bottom: 1.5rem;
            font-size: 2.2em;
            font-weight: 600;
        }

        .login-form hr {
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

        .is-invalid {
            border-color: #dc3545;
            background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 12 12' width='12' height='12' fill='none' stroke='%23dc3545'%3e%3ccircle cx='6' cy='6' r='4.5'/%3e%3cpath stroke-linejoin='round' d='M5.8 3.6h.4L6 6.5z'/%3e%3ccircle cx='6' cy='8.2' r='.6' fill='%23dc3545' stroke='none'/%3e%3c/svg%3e");
            background-repeat: no-repeat;
            background-position: right 0.75rem center;
            background-size: 16px 12px;
        }

        .invalid-feedback {
            color: #dc3545;
            font-size: 0.875em;
            margin-top: 0.25rem;
            display: none;
        }

        .is-invalid ~ .invalid-feedback {
            display: block;
        }

        .btn-login {
            width: 100%;
            padding: 1rem;
            background: #6c757d;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-login:hover {
            background: #5a6268;
            transform: translateY(-1px);
        }

        .btn-login:active {
            background: #495057;
            transform: translateY(0);
        }

        .registration-link {
            text-align: center;
            margin-top: 1.5rem;
            color: #6c757d;
        }

        .registration-link a {
            color: #3498db;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .registration-link a:hover {
            color: #2980b9;
            text-decoration: underline;
        }

        @media (max-width: 576px) {
            .login-container {
                margin: 1rem;
                padding: 1.5rem;
            }

            .login-title {
                font-size: 1.8em;
            }
        }
    </style>

    <div class="login-container">
        <h1 class="login-title">Авторизация</h1>
        <hr>
        <form class="login-form" action="/login" method="post">
            <div class="form-group">
                <label for="email">Электронная почта</label>
                <input type="email"
                       class="form-control <#if RequestParameters.error??>is-invalid</#if>"
                       id="email"
                       name="username"
                       placeholder="example@mail.ru">
                <div class="invalid-feedback">
                    Неверная электронная почта
                </div>
            </div>
            <div class="form-group">
                <label for="password">Пароль</label>
                <input type="password"
                       class="form-control <#if RequestParameters.error??>is-invalid</#if>"
                       id="password"
                       name="password"
                       placeholder="Введите ваш пароль">
                <div class="invalid-feedback">
                    Неверный пароль
                </div>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}">
            <button type="submit" class="btn-login">Войти</button>
        </form>
        <div class="registration-link">
            <h2>Нет аккаунта GoodsMarket? <a href="/registration">Зарегистрируйтесь!</a></h2>
        </div>
    </div>
</@t.template>