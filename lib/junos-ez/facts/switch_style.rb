Junos::Ez::Facts::Keeper.define( :switch_style ) do |ndev, facts|
  f_persona = uses :personality
    
  facts[:switch_style] = case f_persona
  when :SWITCH, :SRX_BRANCH
    case facts[:hardwaremodel]
    when /junosv-firefly/i
      :NONE
    when /^(ex9)|(ex43)/i
      :VLAN_L2NG
    when /^(qfx5)|(qfx3)/i
      if facts[:version][0..3].to_f >= 13.2
        :VLAN_L2NG
      else
        :VLAN
      end
    else
      :VLAN
    end        
  when :MX, :SRX_HIGHEND
    :BRIDGE_DOMAIN
  else
    :NONE
  end

end
    

