sampler Color_1_sampler : register(s0);
sampler Color_2_sampler : register(s1);
sampler Shadow_Tex_sampler : register(s11);
sampler Spec_Pow_sampler : register(s6);
float4 ambient_rate : register(c40);
float4 ambient_rate_rate : register(c71);
float3 fog : register(c67);
float4 g_All_Offset : register(c76);
float g_ShadowUse : register(c180);
float4 g_TargetUvParam : register(c194);
float4 light_Color : register(c61);
float4 lightpos : register(c62);
float4 muzzle_light : register(c69);
float4 muzzle_lightpos : register(c70);
sampler normalmap_sampler : register(s4);
float4 point_light1 : register(c63);
float4 point_lightpos1 : register(c64);
float4 prefogcolor_enhance : register(c77);
float4 specularParam : register(c41);
float4 tile : register(c43);

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
	float4 texcoord8 : TEXCOORD8;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float4 r4;
	float3 r5;
	r0.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.xyz = normalize(r0.xyz);
	r0.xyz = i.texcoord3.xyz;
	r2.xyz = r0.yzx * i.texcoord2.zxy;
	r0.xyz = i.texcoord2.yzx * r0.zxy + -r2.xyz;
	r2.xy = g_All_Offset.xy;
	r2 = i.texcoord.xyxy * tile + r2.xyxy;
	r3 = tex2D(normalmap_sampler, r2);
	r2 = tex2D(Color_2_sampler, r2.zwzw);
	r3.xyz = r3.xyz + -0.5;
	r0.xyz = r0.xyz * -r3.yyy;
	r0.w = r3.x * i.texcoord2.w;
	r0.xyz = r0.www * i.texcoord2.xyz + r0.xyz;
	r0.xyz = r3.zzz * i.texcoord3.xyz + r0.xyz;
	r3.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, r3.xyz);
	r0.xyz = r0.xxx * point_light1.xyz;
	r0.xyz = r0.xyz * i.texcoord8.xxx;
	r1.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r1.xyz);
	r0.w = dot(r4.xyz, r3.xyz);
	r1.xyz = r0.www * muzzle_light.xyz;
	r0.xyz = r1.xyz * i.texcoord8.zzz + r0.xyz;
	r0.w = 1 / i.texcoord7.w;
	r1.xy = r0.ww * i.texcoord7.xy;
	r1.xy = r1.xy * float2(0.5, -0.5) + 0.5;
	r1.xy = r1.xy + g_TargetUvParam.xy;
	r1 = tex2D(Shadow_Tex_sampler, r1);
	r0.w = r1.z + g_ShadowUse.x;
	r1.x = dot(lightpos.xyz, r3.xyz);
	r1.y = r1.x;
	r1.yzw = r1.yyy * light_Color.xyz;
	r0.xyz = r1.yzw * r0.www + r0.xyz;
	r1.yz = -r2.yy + r2.xz;
	r3.w = max(abs(r1.y), abs(r1.z));
	r1.y = r3.w + -0.015625;
	r1.z = (-r1.y >= 0) ? 0 : 1;
	r1.y = (r1.y >= 0) ? -0 : -1;
	r1.y = r1.y + r1.z;
	r1.y = (r1.y >= 0) ? -r1.y : -0;
	r2.xz = (r1.yy >= 0) ? r2.yy : r2.xz;
	r1.yz = g_All_Offset.xy + i.texcoord.xy;
	r4 = tex2D(Color_1_sampler, r1.yzzw);
	r1.yz = -r4.yy + r4.xz;
	r3.w = max(abs(r1.y), abs(r1.z));
	r1.y = r3.w + -0.015625;
	r1.z = (-r1.y >= 0) ? 0 : 1;
	r1.y = (r1.y >= 0) ? -0 : -1;
	r1.y = r1.y + r1.z;
	r1.y = (r1.y >= 0) ? -r1.y : -0;
	r4.xz = (r1.yy >= 0) ? r4.yy : r4.xz;
	r1.y = r2.w * i.color.w;
	r5.xyz = lerp(r2.xyz, r4.xyz, r1.yyy);
	r1.yzw = r5.xyz * i.color.xyz;
	r2.xyz = r5.xyz * i.color.xyz + specularParam.www;
	r0.xyz = r0.xyz * r1.yzw;
	r1.yzw = r1.yzw * ambient_rate.xyz;
	r1.yzw = r1.yzw * ambient_rate_rate.xyz;
	r2.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.x = r1.x + -r2.w;
	r1.x = r1.x + 1;
	r0.xyz = r1.yzw * r1.xxx + r0.xyz;
	r1.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.x = 1 / sqrt(r1.x);
	r1.xyz = -i.texcoord1.xyz * r1.xxx + lightpos.xyz;
	r4.xyz = normalize(r1.xyz);
	r1.x = dot(r4.xyz, r3.xyz);
	r1.y = -r1.x + 1;
	r1.x = r1.y * -specularParam.z + r1.x;
	r1.y = specularParam.y;
	r1 = tex2D(Spec_Pow_sampler, r1);
	r1.xyz = r1.xyz * light_Color.xyz;
	r1.xyz = r4.www * r1.xyz;
	r1.xyz = r0.www * r1.xyz;
	r0.w = abs(specularParam.x);
	r1.xyz = r0.www * r1.xyz;
	r0.xyz = r1.xyz * r2.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
