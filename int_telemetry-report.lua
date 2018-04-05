-- Auto-generated dissector from P4 header

-- Helper functions

-- Return a slice of a table
function table_slice(input_table, first, last)
  local subtable = {}
  for i = first, last do
    subtable[#subtable + 1] = input_table[i]
  end
  return subtable
end

-- Convert a number to bits
function tobits(number, bitcount, first_bit, last_bit)
    local bit_table = {}
    for bit_index = bitcount, 1, -1 do
        remainder = math.fmod(number, 2)
        bit_table[bit_index] = remainder
        number = (number - remainder) / 2
    end
    return table.concat(table_slice(bit_table, first_bit, last_bit))
end


-- Auto generated section

p4_proto = Proto("p4_report_fixed_header","P4_REPORT_FIXED_HEADER Protocol")
p4_int_proto = Proto("p4_int_header", "P4_INT_HEADER Protocol")

function p4_proto.dissector(buffer,pinfo,tree)
    pinfo.cols.protocol = "P4_REPORT_FIXED_HEADER"
    local subtree_report = tree:add(p4_proto,buffer(),"Telemetry Report Fixed Header")
    subtree_report:add(buffer(0,1), "ver (4 bits) - Binary: " .. tobits(buffer(0,1):uint(), 8, 1, 4))
    subtree_report:add(buffer(0,1), "nproto (4 bits) - Binary: " .. tobits(buffer(0,1):uint(), 8, 5, 8))
    subtree_report:add(buffer(1,1), "d (1 bits) - Binary: " .. tobits(buffer(1,1):uint(), 8, 1, 1))
    subtree_report:add(buffer(1,1), "q (1 bits) - Binary: " .. tobits(buffer(1,1):uint(), 8, 2, 2))
    subtree_report:add(buffer(1,1), "f (1 bits) - Binary: " .. tobits(buffer(1,1):uint(), 8, 3, 3))
    subtree_report:add(buffer(1,3), "rsvd (15 bits) - Hex: " .. string.format("%04X", buffer(1,3):bitfield(4, 18)))
    subtree_report:add(buffer(3,1), "hw_id (6 bits) - Binary: " .. tobits(buffer(3,1):uint(), 8, 3, 8))
    subtree_report:add(buffer(4,4), "seq_no (32 bits) - Hex: " .. string.format("%08X", buffer(4,4):bitfield(0, 32)))
    subtree_report:add(buffer(8,4), "ingress_tstamp (32 bits) - Hex: " .. string.format("%08X", buffer(8,4):bitfield(0, 32)))

-- TODO reporting specification drop_report_header and report_local_header is not yet included
	
	local subtree_eth = subtree_report:add(p4_int_proto,buffer(),"Ethernet II")
-- Started Ethernet parsing
	subtree_eth:add(buffer(12,6), "dst_addr (48 bits) - Hex: " .. string.format("%02x:%02x:%02x:%02x:%02x:%02x", 
								buffer(12,1):bitfield(0, 8), buffer(13,1):bitfield(0, 8), 
								buffer(14,1):bitfield(0, 8), buffer(15,1):bitfield(0, 8), 
								buffer(16,1):bitfield(0, 8), buffer(17,1):bitfield(0, 8)))
	subtree_eth:add(buffer(18,6), "src_addr (48 bits) - Hex: " .. string.format("%02x:%02x:%02x:%02x:%02x:%02x", 
								buffer(18,1):bitfield(0, 8), buffer(19,1):bitfield(0, 8), 
								buffer(20,1):bitfield(0, 8), buffer(21,1):bitfield(0, 8), 
								buffer(22,1):bitfield(0, 8), buffer(23,1):bitfield(0, 8)))
	subtree_eth:add(buffer(24,2), "ethertype (16 bits) - Hex: " .. string.format("%04X", buffer(24,2):bitfield(0, 16)))

	local subtree_ipv4 = subtree_report:add(p4_int_proto,buffer(),"Internet Protocol Version 4")
-- Started IPV4 parsing
    subtree_ipv4:add(buffer(26,1), "version (4 bits) - Binary: " .. tobits(buffer(26,1):uint(), 8, 1, 4))
    subtree_ipv4:add(buffer(26,1), "ihl (4 bits) - Binary: " .. tobits(buffer(26,1):uint(), 8, 5, 8))
    subtree_ipv4:add(buffer(27,1), "dscp (6 bits) - Binary: " .. tobits(buffer(27,1):uint(), 8, 1, 6))
    subtree_ipv4:add(buffer(27,1), "ecn (2 bits) - Binary: " .. tobits(buffer(27,1):uint(), 8, 7, 8))
    subtree_ipv4:add(buffer(28,2), "len (16 bits) - Hex: " .. string.format("%04X", buffer(28,2):bitfield(0, 16)))
    subtree_ipv4:add(buffer(30,2), "identification (16 bits) - Hex: " .. string.format("%04X", buffer(30,2):bitfield(0, 16)))
    subtree_ipv4:add(buffer(32,1), "flags (3 bits) - Binary: " .. tobits(buffer(32,1):uint(), 8, 1, 3))
    subtree_ipv4:add(buffer(32,2), "frag_offset (13 bits) - Hex: " .. string.format("%04X", buffer(32,2):bitfield(3, 13)))
    subtree_ipv4:add(buffer(34,1), "ttl (8 bits) - Hex: " .. string.format("%02X", buffer(34,1):bitfield(0, 8)))
    subtree_ipv4:add(buffer(35,1), "protocol (8 bits) - Hex: " .. string.format("%02X", buffer(35,1):bitfield(0, 8)))
	ipv4_protocol = buffer(35,1):bitfield(0,8)
    subtree_ipv4:add(buffer(36,2), "hdr_checksum (16 bits) - Hex: " .. string.format("%04X", buffer(36,2):bitfield(0, 16)))
    -- subtree_ipv4:add(buffer(38,4), "src_addr (32 bits) - Hex: " .. string.format("%08X", buffer(38,4):bitfield(0, 32)))
	subtree_ipv4:add(buffer(38,4), "src_addr (32 bits) - " .. string.format("%d.%d.%d.%d", 
								buffer(38,1):bitfield(0, 8), buffer(39,1):bitfield(0, 8), 
								buffer(40,1):bitfield(0, 8), buffer(41,1):bitfield(0, 8)))
    -- subtree_ipv4:add(buffer(42,4), "dst_addr (32 bits) - " .. string.format("%08X", buffer(42,4):bitfield(0, 32)))
	subtree_ipv4:add(buffer(42,4), "dst_addr (32 bits) - " .. string.format("%d.%d.%d.%d", 
								buffer(42,1):bitfield(0, 8), buffer(43,1):bitfield(0, 8), 
								buffer(44,1):bitfield(0, 8), buffer(45,1):bitfield(0, 8)))

	local subtree_ipv4_proto
	-- TCP
	if(ipv4_protocol == 0x06) then
		subtree_ipv4_proto = subtree_report:add(p4_int_proto,buffer(),"Transmission Control Protocol")
	-- UDP 	
	else -- ipv4_protocol == 0x11
	    subtree_ipv4_proto = subtree_report:add(p4_int_proto,buffer(),"User Datagram Protocol")
	end

	subtree_ipv4_proto:add(buffer(46,2), "src_port (16 bits) - " .. string.format("%d", buffer(46,2):bitfield(0, 16)))
	subtree_ipv4_proto:add(buffer(48,2), "dst_port (16 bits) - " .. string.format("%d", buffer(48,2):bitfield(0, 16)))
	subtree_ipv4_proto:add(buffer(50,4), "seq_no (32 bits) - Hex: " .. string.format("%08X", buffer(50,4):bitfield(0, 32)))
	subtree_ipv4_proto:add(buffer(54,4), "ack_no (32 bits) - Hex: " .. string.format("%08X", buffer(54,4):bitfield(0, 32)))
	subtree_ipv4_proto:add(buffer(58,1), "data_offset (4 bits) - Binary: " .. tobits(buffer(58,1):uint(), 8, 1, 4))
	subtree_ipv4_proto:add(buffer(58,1), "res (3 bits) - Binary: " .. tobits(buffer(58,1):uint(), 8, 5, 7))
	subtree_ipv4_proto:add(buffer(58,2), "ecn (3 bits) - Binary: " .. tobits(buffer(58,2):uint(), 16, 8, 10))
	subtree_ipv4_proto:add(buffer(59,1), "ctrl (6 bits) - Binary: " .. tobits(buffer(59,1):uint(), 8, 3, 8))
	subtree_ipv4_proto:add(buffer(60,2), "window (16 bits) - Hex: " .. string.format("%04X", buffer(60,2):bitfield(0, 16)))
	subtree_ipv4_proto:add(buffer(62,2), "checksum (16 bits) - Hex: " .. string.format("%04X", buffer(62,2):bitfield(0, 16)))
	subtree_ipv4_proto:add(buffer(64,2), "urgent_ptr (16 bits) - Hex: " .. string.format("%04X", buffer(64,2):bitfield(0, 16)))


	local subtree_int = subtree_report:add(p4_int_proto,buffer(),"INT")
	local subtree_int_shim = subtree_int:add(p4_int_proto,buffer(),"INT Shim")
--parse INT shim header -- intl4_shim
    subtree_int_shim:add(buffer(66,1), "int_type (8 bits) - Hex: " .. string.format("%02X", buffer(66,1):bitfield(0, 8)))
    subtree_int_shim:add(buffer(67,1), "rsvd1 (8 bits) - Hex: " .. string.format("%02X", buffer(67,1):bitfield(0, 8)))
    subtree_int_shim:add(buffer(68,1), "len (8 bits) - Hex: " .. string.format("%02X", buffer(68,1):bitfield(0, 8)))
    subtree_int_shim:add(buffer(69,1), "rsvd2 (8 bits) - Hex: " .. string.format("%02X", buffer(69,1):bitfield(0, 8)))

	local subtree_int_header = subtree_int:add(p4_int_proto,buffer(),"INT Header")
--parse INT metadata header -- int_header
	--subtree_int_header:add(buffer(70,2), "controlField (16 bits) - Hex: " .. string.format("%04X", buffer(70,2):bitfield(0, 16)))
    subtree_int_header:add(buffer(70,1), "ver (2 bits) - Binary: " .. tobits(buffer(70,1):uint(), 8, 1, 2))
    subtree_int_header:add(buffer(70,1), "rep (2 bits) - Binary: " .. tobits(buffer(70,1):uint(), 8, 3, 4))
    subtree_int_header:add(buffer(70,1), "c (1 bit) - Binary: " .. tobits(buffer(70,1):uint(), 8, 5, 5))
    subtree_int_header:add(buffer(70,1), "e (1 bit) - Binary: " .. tobits(buffer(70,1):uint(), 8, 6, 6))
    subtree_int_header:add(buffer(70,2), "rsvd1 (5 bits) - Binary: " .. tobits(buffer(70,2):uint(), 16, 7, 11))
    subtree_int_header:add(buffer(71,1), "ins_cnt (5 bits) - Binary: " .. tobits(buffer(71,1):uint(), 8, 4, 8))
    subtree_int_header:add(buffer(72,1), "maxHopCnt (8 bits) - " .. string.format("%d", buffer(72,1):bitfield(0, 8)))
    subtree_int_header:add(buffer(73,1), "totalHopCnt (8 bits) - " .. string.format("%d", buffer(73,1):bitfield(0, 8)))
	totalHopCnt = buffer(73,1):bitfield(0, 8) -- switch number
    subtree_int_header:add(buffer(74,2), "instructionBitmap (16 bits) - Hex: " .. string.format("%04X", buffer(74,2):bitfield(0, 16)))
    subtree_int_header:add(buffer(76,2), "rsvd2 (16 bits) - Hex: " .. string.format("%04X", buffer(76,2):bitfield(0, 16)))
   
	local subtree_int_data = subtree_int:add(p4_int_proto,buffer(),"INT Data")
--parse INT metadata -- int_data
	curser = 78
	index = 0
	subtree_str = ""
	for i = 1, totalHopCnt do
		subtree_str = string.format("%s%d", "switch_", index)
		index = index + 1
		
		local subtree_switch = subtree_int_data:add(p4_int_proto,buffer(),subtree_str)

		if(bit.band(buffer(74,2):bitfield(0, 16), 0x8000) ~= 0) then
			subtree_switch:add(buffer(curser,4), "switch_id (32 bits) - Hex: " .. string.format("%08X", buffer(curser,4):bitfield(0, 32)))
			curser = curser + 4
		end
		if(bit.band(buffer(74,2):bitfield(0, 16), 0x4000) ~= 0) then
			subtree_switch:add(buffer(curser, 2), "ingress_port_id (16 bits) - " .. string.format("%d", buffer(curser,2):bitfield(0, 16)))
			subtree_switch:add(buffer(curser, 2), "engress_port_id (16 bits) - " .. string.format("%d", buffer(curser,2):bitfield(0, 16)))
			curser = curser + 4
		end
		if(bit.band(buffer(74,2):bitfield(0, 16), 0x2000) ~= 0) then
			subtree_switch:add(buffer(curser, 4), "hop_latency (32 bits) - Hex: " .. string.format("%08X", buffer(cuser,4):bitfield(0, 32)))
			curser = curser + 4
		end
		if(bit.band(buffer(74,2):bitfield(0, 16), 0x1000) ~= 0) then
			subtree_switch:add(buffer(curser,1), "q_id (8 bits) - " .. string.format("%d", buffer(curser,1):bitfield(0, 8)))
			subtree_switch:add(buffer(curser,3), "q_occupancy (24 bits) - Hex: " .. string.format("%06X", buffer(curser,3):bitfield(0, 24)))
			curser = curser + 4
		end
		if(bit.band(buffer(74,2):bitfield(0, 16), 0x0800) ~= 0) then
			subtree_switch:add(buffer(curser, 4), "ingress_tstamp (32 bits) - Hex: " .. string.format("%08X", buffer(curser,4):bitfield(0, 32)))
			curser = curser + 4
		end
		if(bit.band(buffer(74,2):bitfield(0, 16), 0x0400) ~= 0) then
			subtree_switch:add(buffer(curser,4), "egress_tstamp (32 bits) - Hex: " .. string.format("%08X", buffer(curser,4):bitfield(0, 32)))
			curser = curser + 4
		end
		if(bit.band(buffer(74,2):bitfield(0, 16), 0x0200) ~= 0) then
			subtree_switch:add(buffer(curser,1), "q_id (8 bits) - " .. string.format("%d", buffer(curser,1):bitfield(0, 8)))
			subtree_switch:add(buffer(curser,3), "q_congestion (24 bits) - Hex: " .. string.format("%06X", buffer(curser, 3):bitfield(0, 24)))
			curser = curser + 4
		end
		if(bit.band(buffer(74,2):bitfield(0, 16), 0x0100) ~= 0) then
			subtree_switch:add(buffer(curser,4), "egress_port_tx_util (32 bits) - Hex: " .. string.format("%08X", buffer(curser,4):bitfield(0, 32)))
			curser = curser + 4
		end
	end

	local subtree_int_tail = subtree_int:add(p4_int_proto,buffer(),"INT Tail")
--parse intl4_tail
    subtree_int_tail:add(buffer(curser,1), "next_proto (8 bits) - Hex: " .. string.format("%02X", buffer(curser,1):bitfield(0, 8)))
    curser = curser + 1
    subtree_int_tail:add(buffer(curser,2), "dest_port (16 bits) - " .. string.format("%d", buffer(curser,2):bitfield(0, 16)))
    curser = curser + 2
    subtree_int_tail:add(buffer(curser,1), "dscp (8 bits) - Hex: " .. string.format("%02X", buffer(curser,1):bitfield(0, 8)))

end

my_table = DissectorTable.get("udp.port")
my_table:add(1234, p4_proto)

