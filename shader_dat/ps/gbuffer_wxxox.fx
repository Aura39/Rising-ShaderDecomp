float4 g_All_Offset : register(c49);
float4 g_ColorEnhance : register(c50);
sampler g_Color_1_sampler : register(s0);
float4 g_GroundHemisphereColor : register(c190);
sampler g_Normalmap_sampler : register(s4);
sampler g_OcclusionSampler : register(s2);
float4 g_SkyHemisphereColor : register(c189);
float4 g_ambientRate : register(c191);
float4 g_cubeParam2 : register(c43);
float4 g_lightColor : register(c47);
float3 g_lightDir : register(c46);
float4 g_normalmapRate : register(c44);
float4 g_olcParam : register(c48);
float4 g_otherParam : register(c45);

struct PS_IN
{
	float3 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color : COLOR;
	float4 color1 : COLOR1;
	float4 color2 : COLOR2;
	float4 color3 : COLOR3;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float3 r2;
	float3 r3;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1 = r0.w + -g_otherParam.y;
	clip(r1);
	r1 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r1.xyz = r1.xyz + -1;
	r0.w = abs(g_normalmapRate.x);
	r1.xyz = r0.www * r1.xyz + 1;
	r0.xyz = r0.xyz * r1.xyz;
	r1.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r0.xyz = r0.xyz * r1.xyz;
	r1 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r1.yz = -r1.xw + 1;
	r1.xy = g_ambientRate.ww * r1.yz + r1.xw;
	o.color.xyz = r0.xyz * r1.yyy;
	r2.xyz = normalize(i.texcoord3.xyz);
	o.color1.xyz = r2.xyz * 0.5 + 0.5;
	r3.xyz = normalize(-i.texcoord1.xyz);
	r0.w = dot(r3.xyz, r2.xyz);
	r1.y = dot(g_lightDir.xyz, r2.xyz);
	r1.y = r1.y + 0.5;
	r1.z = 0.5;
	r0.w = r0.w * g_olcParam.w + r1.z;
	r1.w = frac(r0.w);
	r0.w = r0.w + -r1.w;
	r1.z = r1.z + g_olcParam.y;
	r1.w = frac(r1.z);
	r1.z = -r1.w + r1.z;
	r1.z = 1 / r1.z;
	r0.w = r0.w * -r1.z + 1;
	r0.w = r0.w * g_olcParam.z;
	r1.z = frac(r1.y);
	r1.y = -r1.z + r1.y;
	r1.z = -r1.y + 1;
	r1.y = r1.y + g_olcParam.x;
	r0.w = r0.w * r1.z;
	r2.xyz = r0.xyz * g_lightColor.xyz;
	r0.xyz = r0.xyz * r1.xxx;
	o.color.w = r1.x;
	r1.xzw = r0.www * r2.xyz;
	r0.w = 0.1 + -i.texcoord3.w;
	r2.xyz = r0.www * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r2.xyz = g_SkyHemisphereColor.xyz * r0.www + r2.xyz;
	r2.xyz = r2.xyz + g_ambientRate.xyz;
	r0.xyz = r0.xyz * r2.xyz;
	o.color2.xyz = r0.xyz * r1.yyy + r1.xzw;
	o.color1.w = g_otherParam.x;
	o.color2.w = g_otherParam.z;
	r0.w = g_ambientRate.w;
	o.color3.xzw = r0.www * float3(-1, 0, 0) + float3(1, 0, 0);
	o.color3.y = g_cubeParam2.w;

	return o;
}
