@echo off
echo Iniciando configuración de Llama Express...

echo Creando el proyecto Next.js...
npx create-next-app@latest llama-express-frontend --typescript --tailwind --app --use-npm
if %errorlevel% neq 0 (
    echo Error al crear el proyecto Next.js. Código de error: %errorlevel%
    goto :error
)

echo Cambiando al directorio del proyecto...
cd llama-express-frontend
if %errorlevel% neq 0 (
    echo Error al cambiar al directorio del proyecto. Código de error: %errorlevel%
    goto :error
)

echo Instalando dependencias de Supabase...
npm install @supabase/supabase-js @supabase/auth-helpers-nextjs
if %errorlevel% neq 0 (
    echo Error al instalar dependencias. Código de error: %errorlevel%
    goto :error
)

echo Creando directorio lib...
mkdir lib
if %errorlevel% neq 0 (
    echo Error al crear el directorio lib. Código de error: %errorlevel%
    goto :error
)

echo Creando archivo de configuración de Supabase...
(
echo import { createClient } from '@supabase/supabase-js'
echo.
echo export const supabase = createClient(
echo   process.env.NEXT_PUBLIC_SUPABASE_URL!,
echo   process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!
echo ^)
) > lib\supabase.ts

echo Modificando el archivo page.tsx...
(
echo 'use client'
echo import { useEffect, useState } from 'react'
echo import { supabase } from '../lib/supabase'
echo.
echo export default function Home() {
echo   const [orders, setOrders] = useState([])
echo.
echo   useEffect(() =^> {
echo     async function fetchOrders() {
echo       const { data, error } = await supabase.from('orders').select('*')
echo       if (data^) setOrders(data^)
echo       if (error^) console.error('Error fetching orders:', error^)
echo     }
echo     fetchOrders()
echo   }, []^)
echo.
echo   return (
echo     ^<main className="flex min-h-screen flex-col items-center justify-between p-24"^>
echo       ^<h1 className="text-4xl font-bold mb-8"^>Llama Express^</h1^>
echo       ^<div^>
echo         ^<h2 className="text-2xl mb-4"^>Órdenes Recientes:^</h2^>
echo         {orders.map((order: any^) =^> (
echo           ^<div key={order.id} className="mb-2 p-2 border rounded"^>
echo             ^<p^>Orden ID: {order.id}^</p^>
echo             ^<p^>Estado: {order.status}^</p^>
echo             ^<p^>Dirección de entrega: {order.delivery_address}^</p^>
echo           ^</div^>
echo         ^)^)}
echo       ^</div^>
echo     ^</main^>
echo   ^)
echo }
) > app\page.tsx

echo Creando archivo .env.local...
(
echo NEXT_PUBLIC_SUPABASE_URL=tu_url_de_supabase
echo NEXT_PUBLIC_SUPABASE_ANON_KEY=tu_clave_anonima_de_supabase
) > .env.local

echo Configuración completada con éxito.
echo Por favor, edita el archivo .env.local con tus credenciales de Supabase.
echo Para iniciar el servidor de desarrollo, ejecuta: cd llama-express-frontend ^&^& npm run dev
goto :end

:error
echo.
echo Se encontró un error durante la ejecución del script.
echo Por favor, revisa los mensajes de error anteriores.

:end
echo.
echo Presiona cualquier tecla para cerrar esta ventana...
pause >nul