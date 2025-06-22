<#import "blocks/template.ftlh" as t>
<@t.template user>
    <style>
        :root {
            --text-gray: #6c757d;
            --primary: #2A2F4F;
            --secondary: #917FB3;
            --accent: #E5BEEC;
            --light: #FDE2F3;
            --dark: #1A1A2E;
        }

        .product-card {
            border: none;
            border-radius: 15px;
            transition: all 0.4s cubic-bezier(0.22, 1, 0.36, 1);
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
            overflow: hidden;
            position: relative;
            background: white;
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 32px rgba(0,0,0,0.12);
        }

        .product-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            border-radius: 15px;
            border: 2px solid transparent;
            transition: border-color 0.3s ease;
        }

        .img-wrapper {
            overflow: hidden;
            position: relative;
            border-radius: 15px 15px 0 0;
        }

        .product-img {
            height: 280px;
            object-fit: cover;
            transition: transform 0.4s ease, filter 0.3s ease;
        }

        .product-card:hover .product-img {
            transform: scale(1.08);
            filter: brightness(1.05);
        }

        .card-body {
            padding: 1.5rem;
            position: relative;
        }

        .card-title {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--text-gray);
            margin-bottom: 1rem;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .price-tag {
            font-size: 1.5rem;
            color: var(--text-gray);
            font-weight: 800;
            position: relative;
            display: inline-flex;
            align-items: center;
            gap: 4px;
        }

        .price-tag::before {
            content: '₽';
            font-size: 1rem;
            margin-right: 2px;
            opacity: 0.8;
        }

        .city-badge {
            background: var(--light);
            color: var(--text-gray);
            padding: 0.4rem 1.2rem;
            border-radius: 30px;
            font-size: 0.9rem;
            font-weight: 500;
            box-shadow: 0 2px 6px rgba(0,0,0,0.08);
        }

        .time-stamp {
            position: absolute;
            top: -20px;
            right: 15px;
            background: white;
            padding: 0.4rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            box-shadow: 0 2px 8px rgba(0,0,0,0.08);
            color: var(--primary);
        }

        .no-image {
            height: 280px;
            background: linear-gradient(135deg, var(--light) 0%, #ffffff 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .no-image i {
            font-size: 3rem;
            color: var(--secondary);
            opacity: 0.3;
            transition: transform 0.3s ease;
        }

        .product-card:hover .no-image i {
            transform: scale(1.1);
        }

    </style>

    <div class="container">
        <h1 class="text-center mb-4 display-4 font-weight-bold">Найди нужный товар</h1>

        <div class="search-section">
            <form method="get" action="/">
                <div class="form-row align-items-end">
                    <div class="form-group col-md-3">
                        <label for="searchCity" class="font-weight-bold">Город</label>
                        <select id="searchCity" name="city" class="form-control custom-select">
                            <option value="">Все города</option>
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

                    <div class="form-group col-md-7">
                        <label for="searchWord" class="font-weight-bold">Что ищем?</label>
                        <div class="input-group">
                            <input type="text"
                                   name="searchWord"
                                   value="${searchWord!''}"
                                   class="form-control"
                                   id="searchWord"
                                   placeholder="Например: велосипед или iPhone">
                        </div>
                    </div>

                    <div class="form-group col-md-2 d-flex align-items-end">
                        <button type="submit" class="btn btn-dark btn-block">Поиск</button>
                    </div>
                </div>
            </form>
        </div>

        <div class="card-columns" style="column-count: 3;">
            <#list products as product>
                <a href="/product/${product.id}" class="product-link text-decoration-none">
                    <div class="card product-card mb-4">
                        <#if product.previewImageId??>
                            <div class="img-wrapper" style="overflow: hidden;">
                                <img src="/images/${product.previewImageId}?v=${.now?time}"
                                     class="card-img-top product-img"
                                     alt="${product.title}">
                            </div>
                        <#else>
                            <div class="no-image">
                                <i class="fas fa-image fa-3x"></i>
                            </div>
                        </#if>

                        <div class="card-body">
                            <h5 class="card-title">${product.title}</h5>
                            <div class="d-flex justify-content-between align-items-center">
                                <span class="price-tag">${product.price} </span>
                                <span class="city-badge">${product.city}</span>
                            </div>
                            <small class="text-muted d-block mt-2">
                                <i class="far fa-clock"></i> ${product.dateOfCreated}
                            </small>
                        </div>
                    </div>
                </a>
            <#else>
                <div class="text-center py-5">
                    <i class="fas fa-search fa-3x text-muted mb-3"></i>
                    <h3 class="text-muted">Ничего не найдено</h3>
                    <p class="text-muted">Попробуйте изменить параметры поиска</p>
                </div>
            </#list>
        </div>
    </div>
</@t.template>