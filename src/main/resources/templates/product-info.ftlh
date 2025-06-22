<#import "blocks/template.ftlh" as t>
<@t.template user>
    <style>
            /* Стили для чёрных стрелок */
            .carousel-control-prev-icon {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='%23000'%3e%3cpath d='M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0z'/%3e%3c/svg%3e");
            }

            .carousel-control-next-icon {
                background-image: url("data:image/svg+xml,%3csvg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 16 16' fill='%23000'%3e%3cpath d='M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708z'/%3e%3c/svg%3e");
            }

            .carousel-control-prev,
            .carousel-control-next {
                width: 5%;
                background: rgba(255, 255, 255, 0.3);
                border-radius: 50%;
            }

            /* Стили для кастомной подписи */
            .custom-caption {
                position: static;
                padding: 20px;
                background: #f8f9fa;
                border-radius: 5px;
                margin-top: 15px;
            }

            /* Стили для изображений */
            .carousel-image {
                height: 600px;
                object-fit: contain;
                width: 100%;
            }

            /* Позиционирование индикаторов */
            .carousel-indicators {
                bottom: -40px;
            }
            .carousel-indicators li {
                background-color: #000 !important;
            }
        </style>

    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner">
            <#list images as image>
                <div class="carousel-item <#if image.previewImage!>active</#if>">
                    <div class="container">
                        <a href="/images/${image.id}" class="d-block w-100">
                            <img class="d-block w-100" src="/images/${image.id}"
                                 style="height: 600px; object-fit: contain"
                                 alt="${product.title}">
                        </a>
                    </div>


                </div>
            </#list>
        </div>

        <!-- Индикаторы теперь внизу -->
        <ol class="carousel-indicators" style="bottom: -40px">
            <#list images as image>
                <li data-target="#myCarousel" data-slide-to="${image?index}"
                    class="<#if image?index == 0>active</#if> bg-dark"></li>
            </#list>
        </ol>

        <!-- Стрелки управления -->
        <a class="carousel-control-prev" href="#myCarousel" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#myCarousel" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>

    <!-- Перенесенная и модифицированная подпись -->
    <div class="custom-caption text-center">
            <h5>${product.title}</h5>
            <p>Цена: ${product.price} ₽</p>
            <p>Дата публикации: ${product.dateOfCreated}</p>
    </div>

    <!-- Остальной контент -->
    <div class="container mt-4">
        <p class="text-left">${product.description}</p>
        <p class="text-center">Контакты: <b>${authorProduct.phoneNumber}</b></p>
        <div class="text-center">

            <#if authorProduct.avatar??>
                <a href="/user/${authorProduct.id}" class="btn btn-outline-dark">
                    <img src="/images/${authorProduct.avatar.id}" alt="avatar" width="32" height="32" class="rounded-circle">
                    ${authorProduct.name}
                </a>
            <#else>
                <a href="/user/${authorProduct.id}" class="btn btn-outline-dark">
                    <img src="/static/images/avatar.png" alt="avatar" width="32" height="32" class="rounded-circle">
                    ${authorProduct.name}
                </a>
            </#if>

        </div>
    </div>
</@t.template>