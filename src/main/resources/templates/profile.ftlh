<#import "blocks/template.ftlh" as t>
<@t.template user>
    <style>
        :root {
            --primary-gray: #6c757d;
            --gray-hover: #5a6268;
            --gray-active: #495057;
            --danger-color: #dc3545;
        }

        .profile-container {
            max-width: 600px;
            margin: 2rem auto;
            padding: 2rem;
            background: #fff;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }

        .profile-title {
            text-align: center;
            color: var(--primary-gray);
            margin-bottom: 1.5rem;
            font-size: 2.2em;
            font-weight: 600;
        }

        .profile-avatar {
            width: 200px;
            height: 200px;
            object-fit: cover;
            border-radius: 50%;
            transition: transform 0.3s ease;
            border: 3px solid var(--primary-gray);
        }

        .profile-avatar:hover {
            transform: scale(1.05);
            box-shadow: 0 0 15px rgba(108, 117, 125, 0.2);
        }

        .user-name {
            font-size: 1.8em;
            color: #2c3e50;
            margin: 1rem 0;
        }

        .user-info {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 8px;
            margin: 1.5rem 0;
            text-align: left;
            max-width: 400px;
            margin-left: auto;
            margin-right: auto;
        }

        .user-info p {
            margin: 0.8rem 0;
            color: #34495e;
        }

        .user-info b {
            color: var(--primary-gray);
        }

        .profile-btn {
            width: 100%;
            padding: 1rem;
            margin: 0.5rem 0;
            background: #303436;
            color: white;
            border: none;
            border-radius: 6px;
            font-size: 1.1em;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: block;
        }

        .profile-btn:hover {
            background: #191b1c;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(108, 117, 125, 0.2);
            color: white !important; /* Добавляем принудительное наследование цвета */
        }

        .btn-logout {
            background: var(--danger-color);
            margin-top: 1rem;
        }

        .btn-logout:hover {
            background: #c82333;
            color: white !important;
        }

        /* Убираем все синие цвета из кнопок */
        a.profile-btn:hover,
        a.profile-btn:focus,
        a.profile-btn:active {
            color: white;
            text-decoration: none;
        }

        @media (max-width: 576px) {
            .profile-container {
                margin: 1rem;
                padding: 1.5rem;
            }

            .profile-title {
                font-size: 1.8em;
            }

            .profile-avatar {
                width: 150px;
                height: 150px;
            }
        }
    </style>

    <div class="profile-container">
        <h1 class="profile-title">Личный кабинет</h1>
        <hr>

        <div style="text-align: center">
            <#if user.avatar??>
                <img src="/images/${user.avatar.id}" class="profile-avatar">
            <#else>
                <img src="/static/images/avatar.png" class="profile-avatar">
            </#if>

            <h2 class="user-name">${user.name}</h2>

            <div class="user-info">
                <p>Email: <b>${user.email}</b></p>
                <p>Телефон: <b>${user.phoneNumber!''}</b></p>
            </div>

            <a class="profile-btn" href="/profile/edit">
                Редактировать профиль
            </a>

            <#if user.isAdmin()>
                <a class="profile-btn" href="/admin">
                    Панель администратора
                </a>
            </#if>

            <a class="profile-btn" href="/my/products">
                Мои товары
            </a>

            <form action="/logout" method="post">
                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                <button type="submit" class="profile-btn btn-logout">
                    Выйти из аккаунта
                </button>
            </form>
        </div>
    </div>
</@t.template>