# POST:
# check:
# logged in?
# for postcards: User.can_send_postcard; can't send postcards at all if not logged in.
#
#
# save Card > Ecard Postcard....
#		date
#		name of person
#		address
#		message
#	
#	send the card!
#
#
# GET:
# check:
# logged in?
# for postcards: User.can_send_postcard; can't send postcards at all if not logged in.
# if they can't send postcard, redirect to /send with flash message
#
# /send = index ... reminder page that has two buttons
#
# /send/ecard
# /send/postcard
#
# User.get_recent_ecards(num of recent ecards)
#  '' '''' postcards( '''' )
#
# 
