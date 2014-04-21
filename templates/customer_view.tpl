{extends '_template_.tpl'}

{block name=body}
    <h1>{$customer['name']}</h1>
    <div class="clearfix"></div>

    <!-- Tab Nav -->
    <ul class="nav nav-tabs">
        <li class="active"><a href="#contacts" data-toggle="tab">Contacts</a></li>
        <li><a href="#addresses" data-toggle="tab">Addresses</a></li>
        <li><a href="#emails" data-toggle="tab">Emails</a></li>
    </ul>

    <!-- Tabs -->
    <div class="tab-content">
        <div class="tab-pane active" id="contacts">
            <br/>
            <table class="dataTable" cellspacing="0" cellpadding="0" border="0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Contact Date</th>
                    </tr>
                </thead>
                <tbody>
                {foreach item=contact from=$contacts}
                    <tr>
                        <td><span class="badge">{$contact['contact_id']}</span></td>
                        <td><a href="{$base_url}contacts/customer_{$customer['customer_id']}/{$contact['contact_id']}/view" data-toggle="modal" data-target="#modal">{$contact['title']}</a></td>
                        <td>{$contact['date_time']}</td>
                    </tr>
                {/foreach}
                </tbody>
            </table><br/>
            <div class="pull-right">
                <br/>
                <a href="{$base_url}contacts/customer_{$customer['customer_id']}/new" data-toggle="modal" data-target="#modal">
                    <button class="btn btn-primary">Add a new record</button>
                </a>
            </div>
            <div class="clearfix"></div>
        </div><!-- / contacts -->
        <div class="tab-pane" id="addresses">
            <br/>
            <table class="dataTable" cellspacing="0" cellpadding="0" border="0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Address</th>
                        <th>City</th>
                        <th>State</th>
                        <th>Country</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                {foreach item=address from=$addresses}
                    <tr>
                        <td><span class="badge">{$address['address_id']}</span></td>
                        <td>
                            {if $address['primary'] == 1}
                                <i class="glyphicon glyphicon-star-empty"></i>
                            {/if}
                            {$address['address_line_1']}
                            {if $address['address_line_2'] != ''}
                                , {$address['address_line_2']}
                            {/if}
                        </td>
                        <td>{$address['city']}</td>
                        <td>{$address['state_prov_name']}</td>
                        <td>{$address['country_name']}</td>
                        <td>
                            <a href="#" onclick="confirmPath('{$base_url}addresses/{$address['address_id']}/primary/');">
                                <button class="btn btn-sm btn-info">Make Primary</button>
                            </a>
                            <a href="#" onclick="confirmPath('{$base_url}addresses/{$address['address_id']}/delete');">
                                <button class="btn btn-sm btn-danger">Delete</button>
                            </a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table><br/>
            <div class="pull-right">
                <br/>
                <a href="{$base_url}addresses/customer_{$customer['customer_id']}/new/" data-toggle="modal" data-target="#modal">
                    <button class="btn btn-primary">Add a new record</button>
                </a>
            </div>
            <div class="clearfix"></div>
        </div><!-- / addresses -->
        <div class="tab-pane" id="emails">
            <br/>
            <table class="dataTable" cellspacing="0" cellpadding="0" border="0">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Address</th>
                        <th>Type</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                {foreach item=email from=$emails}
                    <tr>
                        <td><span class="badge">{$email['email_id']}</span></td>
                        <td>
                            {if $email['primary'] == 1}
                                <i class="glyphicon glyphicon-star-empty"></i>
                            {/if}
                            <a href="mailto:{$email['address']}">{$email['address']}</a></td>
                        <td>{$email['email_type']}</td>
                        <td>
                            <a href="#" onclick="confirmPath('{$base_url}emails/{$email['email_id']}/primary/');">
                                <button class="btn btn-sm btn-info">Make Primary</button>
                            </a>
                            <a href="#" onclick="confirmPath('{$base_url}emails/{$email['email_id']}/delete');">
                                <button class="btn btn-sm btn-danger">Delete</button>
                            </a>
                        </td>
                    </tr>
                {/foreach}
                </tbody>
            </table>
            <div class="clearfix"><br/><br/></div>
            <div class="well">
                <h5>Add a new customer:</h5>
                <form class="form-inline" role="form" action="{$base_url}emails/add/" method="POST">
                    <input type="hidden" name="customer_id" value="{$customer['customer_id']}"/>
                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" name="email" id="email" placeholder="Enter email">
                    </div>
                    <div class="form-group">
                        <label for="email_type_id">Email type:</label>
                        <select name="email_type_id" id="email_type_id">
                            <option disabled="disabled" selected="selected">-- Choose one --</option>
                            {foreach item=type from=$email_types}
                                <option value="{$type['email_type_id']}">{$type['type_name']}</option>
                            {/foreach}
                        </select>
                    </div>
                    <button type="submit" class="btn btn-default">Add</button>
                </form>
            </div>
        </div><!-- / emails -->
    </div>
{/block}