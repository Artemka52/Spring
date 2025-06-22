<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Редактирование профиля</h1>
    <hr>
    <form method="post" action="/profile/update" enctype="multipart/form-data">
        <div class="form-group">
            <label>Имя</label>
            <input type="text" name="name" class="form-control" value="${user.name}">
        </div>
        <div class="form-group">
            <label>Email</label>
            <input type="email" class="form-control" value="${user.email}" disabled>
        </div>
        <div class="form-group">
            <label>Номер телефона</label>
            <input type="tel" name="phoneNumber" class="form-control" value="${user.phoneNumber}">
        </div>
        <div class="form-group">
            <label>Аватарка</label>
            <input type="file" name="avatarFile" class="form-control-file" accept="image/*">
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}">
        <button type="submit" class="btn btn-dark btn-block">Сохранить изменения</button>
    </form>
</@t.template>