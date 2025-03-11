float4 g_All_Offset : register(c49);
float4 g_ColorEnhance : register(c50);
sampler g_Color_1_sampler : register(s0);
sampler g_Color_2_sampler : register(s1);
float4 g_GroundHemisphereColor : register(c190);
sampler g_Normalmap_sampler : register(s4);
sampler g_OcclusionSampler : register(s2);
float4 g_SkyHemisphereColor : register(c189);
float4 g_ambientRate : register(c191);
float3 g_lightDir : register(c46);
float4 g_normalmapRate : register(c44);
float4 g_otherParam : register(c45);

struct PS_IN
{
	float4 color : COLOR;
	float4 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color1 : COLOR1;
	float4 color : COLOR;
	float4 color2 : COLOR2;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float3 r3;
	float3 r4;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1.x = r0.w + -0.01;
	r1 = r1.x + -g_otherParam.y;
	clip(r1);
	r1 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r1.xyz = r1.xyz * 2 + -1;
	r2.x = r1.x * i.texcoord2.w;
	r2.yz = r1.yz * float2(1, -1);
	r1.xyz = r2.xyz * g_normalmapRate.xxx;
	r2.xyz = normalize(r1.xyz);
	r1.xyz = normalize(i.texcoord2.xyz);
	r3.xyz = normalize(i.texcoord3.xyz);
	r4.xyz = r1.zxy * r3.yzx;
	r4.xyz = r1.yzx * r3.zxy + -r4.xyz;
	r4.xyz = r2.yyy * r4.xyz;
	r1.xyz = r2.xxx * r1.xyz + r4.xyz;
	r1.xyz = r2.zzz * r3.xyz + r1.xyz;
	r1.w = dot(g_lightDir.xyz, r3.xyz);
	r2.xyz = normalize(r1.xyz);
	o.color1.xyz = r2.xyz * 0.5 + 0.5;
	r1.x = dot(g_lightDir.xyz, r2.xyz);
	r1.x = -r1.w + r1.x;
	r1.x = r1.x + 1;
	r1.yz = g_All_Offset.zw * i.texcoord.xy;
	r2 = tex2D(g_Color_2_sampler, r1.yzzw);
	r1.y = r2.w * i.color.w;
	r3.xyz = lerp(r2.xyz, r0.xyz, r1.yyy);
	r1.yzw = g_ColorEnhance.xyz * i.color.xyz;
	r0.xyz = r1.yzw * r3.xyz;
	r2 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r1.y = -r2.x + 1;
	r1.y = g_ambientRate.w * r1.y + r2.x;
	r1.yzw = r0.xyz * r1.yyy;
	o.color = r0;
	o.color2.w = r0.w;
	r0.x = 0.1 + -i.texcoord3.w;
	r0.xyz = r0.xxx * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r0.xyz = g_SkyHemisphereColor.xyz * r0.www + r0.xyz;
	r0.xyz = r0.xyz + g_ambientRate.xyz;
	r0.xyz = r1.yzw * r0.xyz;
	o.color2.xyz = r1.xxx * r0.xyz;
	o.color1.w = g_otherParam.x;

	return o;
}
