/*
    pmacct (Promiscuous mode IP Accounting package)
    pmacct is Copyright (C) 2003-2019 by Paolo Lucente
*/

/*
    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
*/

/* prototypes */
#if !defined(__RPKI_MSG_C)
#define EXT extern
#else
#define EXT
#endif
EXT int rpki_roas_file_load(char *, struct bgp_table *, struct bgp_table *);
EXT int rpki_info_add(struct bgp_peer *, struct prefix *, as_t, u_int8_t, struct bgp_table *, struct bgp_table *);

EXT void rpki_rtr_connect(int *, struct sockaddr_storage *, socklen_t);
EXT void rpki_rtr_send_reset(int *, u_int16_t *);
EXT void rpki_rtr_recv_prefixes(int *, u_int16_t *, u_int32_t *);
#undef EXT
