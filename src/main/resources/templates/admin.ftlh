<#import "blocks/template.ftlh" as t>
<@t.template user>
    <div class="container mt-4">
        <h1 class="text-center mb-4">Панель администратора</h1>
        <hr>

        <div class="table-responsive">
            <table class="table table-hover table-striped table-bordered">
                <thead class="thead-dark">
                    <tr>
                        <th scope="col">Email</th>
                        <th scope="col">Телефон</th>
                        <th scope="col" class="text-center">Статус</th>
                        <th scope="col">Роли</th>
                        <th scope="col" class="text-center">Бан</th>
                        <th scope="col" class="text-center">Действия</th>
                    </tr>
                </thead>
                <tbody>
                    <#list users as user>
                        <tr>
                            <td>${user.email}</td>
                            <td>${user.phoneNumber!''}</td>
                            <td class="text-center">
                                <#if user.active>
                                    <span class="badge badge-success"><i class="fas fa-check-circle"></i> Активен</span>
                                <#else>
                                    <span class="badge badge-danger"><i class="fas fa-times-circle"></i> Заблокирован</span>
                                </#if>
                            </td>
                            <td>
                                <#list user.roles as role>
                                    <span class="badge badge-info">${role}</span>
                                </#list>
                            </td>
                            <td class="text-center">
                                <form action="/admin/user/ban/${user.id}" method="post">
                                    <input type="hidden" name="_csrf" value="${_csrf.token}">
                                    <button type="submit" class="btn btn-sm <#if user.active>btn-outline-danger<#else>btn-outline-success</#if>">
                                        <#if user.active>
                                            <i class="fas fa-ban"></i> Забанить
                                        <#else>
                                            <i class="fas fa-check"></i> Разбанить
                                        </#if>
                                    </button>
                                </form>
                            </td>
                            <td class="text-center">
                                <div class="btn-group">
                                    <a href="/admin/user/edit/${user.id}" class="btn btn-sm btn-outline-warning mr-2">
                                        <i class="fas fa-edit"></i> Редактировать
                                    </a>
                                    <a href="/user/${user.id}" class="btn btn-sm btn-outline-info">
                                        <i class="fas fa-info-circle"></i> Подробнее
                                    </a>
                                </div>
                            </td>
                        </tr>
                    <#else>
                        <tr>
                            <td colspan="6" class="text-center text-muted py-4">
                                <h4><i class="fas fa-users-slash"></i> Пользователей не найдено</h4>
                            </td>
                        </tr>
                    </#list>
                </tbody>
            </table>
        </div>
    </div>

    <style>
        th {
            min-width: 150px;
        }
    </style>
</@t.template>