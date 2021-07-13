%rebase('app', title="Ciencia de Datos")
<h4>
    Exploración de datos:
</h4>
<hr/>
<h5>
    Información Maximos y Minimos por caracteristicas:
</h5>
<div class="divider">
</div>
<table>
    <thead>
        <tr>
            <th>
                Caracteristica
            </th>
            <th>
                Maximo
            </th>
            <th>
                Minimo
            </th>
        </tr>
    </thead>
    <tbody>
        %for label,max,min in zip(columns_detail,maxs,mins):
        <tr>
            <td>
                {{label}}
            </td>
            <td>
                {{min}}
            </td>
            <td>
                {{max}}
            </td>
        </tr>
        %end
    </tbody>
</table>