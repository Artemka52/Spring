<#import "blocks/template.ftlh" as t>
<@t.template user>
    <h1 style="text-align: center">Мои товары</h1>
    <hr>
    <a class="btn btn-dark mt-3 mb-3" style="text-align: center; width: 100%"
       data-toggle="collapse" href="#collapseExample" role="button"
       aria-expanded="true" aria-controls="collapseExample">
        Добавить новый товар
    </a>
    <div class="collapse mb-3" id="collapseExample" style="">
        <form action="/product/create" method="post" enctype="multipart/form-data">
            <div class="form-group">
                <label for="productName">Название товара</label>
                <input type="text" required class="form-control"
                       id="productName" name="title">
            </div>
            <div class="form-group">
                <label for="price">Цена товара</label>
                <div class="input-group mb-3">
                    <input type="number" required class="form-control" id="price" name="price">
                    <div class="input-group-append">
                        <span class="input-group-text">₽</span>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <label for="searchCity">Город</label>
                <select id="searchCity" required name="city" class="form-control">
                    <option value="">Город не выбран</option>

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
                <textarea required class="form-control" id="description" name="description"></textarea>
            </div>
            <div class="form-group">
                <div class="custom-file">
                    <input required type="file" name="files" id="files" multiple accept="image/*">
                    <label class="custom-file-label" for="files">Загрузите фотографии товара (до 8 изображений)</label>
                </div>
                <small class="form-text text-muted">Первое изображение будет использоваться как превью</small>
            </div>
            <input type="hidden" name="_csrf" value="${_csrf.token}"/>

            <button type="submit" style="width: 100%" class="btn btn-dark">Добавить</button>
        </form>
    </div>
    <div class="card-columns">
                <#list products as product>
                    <div class="card text-white bg-dark my-3 product">
                        <div class="card-top d-flex justify-content-between">
                            <!-- Кнопка редактирования -->
                            <a href="/product/edit/${product.id}" class="btn btn-primary m-3" style="color: white">
                                Редактировать
                            </a>
                            <!-- Кнопка удаления -->
                            <form action="/product/delete/${product.id}" method="post">
                                <input type="hidden" name="_csrf" value="${_csrf.token}"/>
                                <button type="submit" class="btn btn-danger m-3" style="color: white">
                                    Удалить
                                </button>
                            </form>
                        </div>
                        <!-- Ссылка на просмотр товара -->
                        <a href="/product/${product.id}" class="product-link">
                            <div class="card text-white bg-dark my-3 product">
                                <#if product.previewImageId??>
                                    <img src="/images/${product.previewImageId}"
                                        class="card-img-top img-fluid"
                                        style="height: 300px; object-fit: cover;">
                                <#else>
                                    <div class="card-img-top img-fluid d-flex align-items-center justify-content-center"
                                        style="height: 300px; background: #2d2d2d;">
                                        <span class="text-muted">Нет изображения</span>
                                    </div>
                                </#if>
                                    <div class="card-body">
                                        <h5 class="card-title">${product.title}</h5>
                                        <p class="card-text">${product.price} ₽</p>
                                        <p class="card-text small">Создано: ${product.dateOfCreated}</p>
                                    </div>
                                    <div class="card-footer">
                                        ${product.city}
                                    </div>
                            </div>
                        </a>
                    </div>
                <#else>
                    <h1 style="text-align: center; color: white">Не найдено</h1>
                </#list>
        </div>
</@t.template>