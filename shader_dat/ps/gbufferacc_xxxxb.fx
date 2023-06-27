float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
sampler g_Color_2_sampler;
float4 g_GroundHemisphereColor;
sampler g_Normalmap_sampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_otherParam;

struct PS_IN
{
	float4 color : COLOR;
	float2 texcoord : TEXCOORD;
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
	r2.yz = r1.yz * float2(2, -1);
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
	r1.y = 0.1 + -i.texcoord3.w;
	r1.yzw = r1.yyy * g_GroundHemisphereColor.xyz;
	r2.x = 0.1 + i.texcoord3.w;
	r1.yzw = g_SkyHemisphereColor.xyz * r2.xxx + r1.yzw;
	r1.yzw = r1.yzw + g_ambientRate.xyz;
	r2.xy = g_All_Offset.zw * i.texcoord.xy;
	r2 = tex2D(g_Color_2_sampler, r2);
	r2.w = r2.w * i.color.w;
	r3.xyz = lerp(r2.xyz, r0.xyz, r2.www);
	r2.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r0.xyz = r2.xyz * r3.xyz;
	r1.yzw = r0.xyz * r1.yzw;
	o.color = r0;
	o.color2.w = r0.w;
	o.color2.xyz = r1.xxx * r1.yzw;
	o.color1.w = g_otherParam.x;

	return o;
}
