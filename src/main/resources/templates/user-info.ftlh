<#import "blocks/template.ftlh" as t>
<@t.template userByPrincipal>

    <style>
            /* Обновленные стили для карточки */
            :root {
                --text-gray: #6c757d;
                --primary: #2A2F4F;
                --secondary: #917FB3;
                --accent: #E5BEEC;
                --light: #FDE2F3;
                --dark: #1A1A2E;
            }

            .profile-section {
                        max-width: 800px;
                        margin: 2rem auto;
                        padding: 2rem;
                        background: white;
                        border-radius: 15px;
                        box-shadow: 0 4px 24px rgba(0,0,0,0.08);
                    }

                    .user-avatar {
                        width: 160px;
                        height: 160px;
                        border: 3px solid var(--light);
                        border-radius: 50%;
                        box-shadow: 0 8px 24px rgba(0,0,0,0.12);
                        transition: all 0.3s ease;
                        object-fit: cover;
                    }

                    .user-avatar:hover {
                        transform: scale(1.05);
                        box-shadow: 0 12px 32px rgba(0,0,0,0.15);
                    }

                    .user-info {
                        margin-top: 1.5rem;
                    }

                    .user-name {
                        color: var(--primary);
                        font-size: 2.2rem;
                        font-weight: 800;
                        margin-bottom: 0.5rem;
                    }

                    .phone-number {
                        font-size: 1.2rem;
                        color: var(--text-gray);
                        display: flex;
                        align-items: center;
                        justify-content: center;
                        gap: 0.5rem;
                        padding: 0.8rem 1.5rem;
                        background: var(--light);
                        border-radius: 30px;
                        display: inline-block;
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



     <div class="profile-section text-center">
            <h1 style="text-align: center">Информация о пользователе</h1>
            <br>
            <#if user.avatar??>
                <img src="/images/${user.avatar.id}" class="user-avatar" alt="${user.name}">
            <#else>
                <img src="/static/images/avatar.png" class="user-avatar" alt="Аватар">
            </#if>

            <div class="user-info">
                <h1 class="user-name">${user.name}</h1>
                <div class="phone-number">
                    <i class="fas fa-phone-alt"></i>
                    ${user.phoneNumber}
                </div>
            </div>
        </div>
    <br>
    <hr>
    <h1 style="text-align: center">Товары пользователя ${user.name}</h1>
    <br>
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
                                    <span class="price-tag">${product.price} ₽</span>
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
</@t.template>