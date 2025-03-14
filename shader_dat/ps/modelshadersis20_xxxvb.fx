sampler Color_1_sampler : register(s0);
sampler Color_2_sampler : register(s1);
sampler Shadow_Tex_sampler : register(s11);
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
	float3 r4;
	r0.x = 1 / i.texcoord7.w;
	r0.xy = r0.xx * i.texcoord7.xy;
	r0.xy = r0.xy * float2(0.5, -0.5) + 0.5;
	r0.xy = r0.xy + g_TargetUvParam.xy;
	r0 = tex2D(Shadow_Tex_sampler, r0);
	r0.x = r0.z + g_ShadowUse.x;
	r0.yzw = point_lightpos1.xyz + -i.texcoord1.xyz;
	r1.xyz = normalize(r0.yzw);
	r2.xyz = i.texcoord3.xyz;
	r0.yzw = r2.yzx * i.texcoord2.zxy;
	r0.yzw = i.texcoord2.yzx * r2.zxy + -r0.yzw;
	r2.xy = g_All_Offset.xy;
	r2 = i.texcoord.xyxy * tile + r2.xyxy;
	r3 = tex2D(normalmap_sampler, r2);
	r2 = tex2D(Color_2_sampler, r2.zwzw);
	r3.xyz = r3.xyz + -0.5;
	r0.yzw = r0.yzw * -r3.yyy;
	r1.w = r3.x * i.texcoord2.w;
	r0.yzw = r1.www * i.texcoord2.xyz + r0.yzw;
	r0.yzw = r3.zzz * i.texcoord3.xyz + r0.yzw;
	r3.xyz = normalize(r0.yzw);
	r0.y = dot(r1.xyz, r3.xyz);
	r0.yzw = r0.yyy * point_light1.xyz;
	r0.yzw = r0.yzw * i.texcoord8.xxx;
	r1.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r1.xyz);
	r1.x = dot(r4.xyz, r3.xyz);
	r1.y = dot(lightpos.xyz, r3.xyz);
	r1.xzw = r1.xxx * muzzle_light.xyz;
	r0.yzw = r1.xzw * i.texcoord8.zzz + r0.yzw;
	r1.x = r1.y;
	r1.xzw = r1.xxx * light_Color.xyz;
	r0.xyz = r1.xzw * r0.xxx + r0.yzw;
	r1.xz = -r2.yy + r2.xz;
	r0.w = max(abs(r1.x), abs(r1.z));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r2.xz = (r0.ww >= 0) ? r2.yy : r2.xz;
	r1.xz = g_All_Offset.xy + i.texcoord.xy;
	r3 = tex2D(Color_1_sampler, r1.xzzw);
	r1.xz = -r3.yy + r3.xz;
	r0.w = max(abs(r1.x), abs(r1.z));
	r0.w = r0.w + -0.015625;
	r1.x = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.x;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r3.xz = (r0.ww >= 0) ? r3.yy : r3.xz;
	r0.w = r2.w * i.color.w;
	r1.xzw = lerp(r2.xyz, r3.xyz, r0.www);
	r1.xzw = r1.xzw * i.color.xyz;
	r0.xyz = r0.xyz * r1.xzw;
	r1.xzw = r1.xzw * ambient_rate.xyz;
	r1.xzw = r1.xzw * ambient_rate_rate.xyz;
	r0.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.w = -r0.w + r1.y;
	r0.w = r0.w + 1;
	r0.xyz = r1.xzw * r0.www + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
