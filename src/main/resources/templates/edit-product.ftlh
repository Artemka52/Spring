<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Редактирование товара</h1>
    <hr>
    <form action="/product/update/${product.id}" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label for="productName">Название товара</label>
            <input type="text" required class="form-control"
                   id="productName" name="title" value="${product.title}">
        </div>
        <div class="form-group">
            <label for="price">Цена товара</label>
            <div class="input-group mb-3">
                <input type="number" required class="form-control"
                       id="price" name="price" value="${product.price}">
                <div class="input-group-append">
                    <span class="input-group-text">₽</span>
                </div>
            </div>
        </div>
        <div class="form-group">
            <label for="city">Город</label>
            <select id="city" required name="city" class="form-control">
                <option value="${product.city}" selected>${product.city}</option>
                <#list [
                    "Абакан", "Анапа", "Архангельск", "Астрахань", "Барнаул",
                    "Белгород", "Благовещенск", "Брянск", "Владивосток",
                    "Владикавказ", "Владимир", "Волгоград", "Вологда", "Воронеж",
                    "Грозный", "Екатеринбург", "Иваново", "Ижевск", "Иркутск",
                    "Йошкар-Ола", "Казань", "Калининград", "Калуга", "Кемерово",
                    "Киров", "Краснодар", "Красноярск", "Курган", "Курск",
                    "Липецк", "Магадан", "Магнитогорск", "Махачкала", "Москва",
                    "Мурманск", "Набережные Челны", "Нижневартовск",
                    "Нижний Новгород", "Новокузнецк", "Новороссийск",
                    "Новосибирск", "Омск", "Оренбург", "Орёл", "Пенза", "Пермь",
                    "Петрозаводск", "Псков", "Ростов-на-Дону", "Рязань", "Самара",
                    "Санкт-Петербург", "Саранск", "Саратов", "Севастополь",
                    "Симферополь", "Смоленск", "Сочи", "Ставрополь", "Сургут",
                    "Тамбов", "Тверь", "Тольятти", "Томск", "Тула", "Тюмень",
                    "Улан-Удэ", "Ульяновск", "Уфа", "Хабаровск", "Ханты-Мансийск",
                    "Чебоксары", "Челябинск", "Чита", "Элиста", "Якутск", "Ярославль"
                ] as cityOption>
                    <option value="${cityOption}"
                        ${(selectedCity?? && selectedCity == cityOption)?then('selected', '')}>
                        ${cityOption}
                    </option>
                </#list>
            </select>
        </div>
        <div class="form-group">
            <label for="description">Описание товара</label>
            <textarea required class="form-control"
                      id="description" name="description">${product.description}</textarea>
        </div>
        <div class="form-group">
            <label>Текущие изображения:</label>
            <div class="row">
                <#list product.images as image>
                    <div class="col-md-4 mb-3">
                        <img src="/images/${image.id}" class="img-thumbnail">
                    </div>
                </#list>
            </div>
        </div>
        <div class="form-group">
            <div class="custom-file">
                <input type="file" name="files" id="files" multiple accept="image/*">
                <label class="custom-file-label" for="files">Загрузите новые изображения (до 8)</label>
            </div>
            <small class="form-text text-muted">Существующие изображения будут заменены выбранными</small>
        </div>
        <input type="hidden" name="_csrf" value="${_csrf.token}"/>
        <button type="submit" class="btn btn-dark btn-block">Сохранить изменения</button>
    </form>
</@t.template>