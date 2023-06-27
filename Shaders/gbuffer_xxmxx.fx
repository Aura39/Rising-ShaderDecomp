float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
float4 g_GroundHemisphereColor;
sampler g_Normalmap_sampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_cubeParam2;
float4 g_lightColor;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_olcParam;
float4 g_otherParam;

struct PS_IN
{
	float3 color : COLOR;
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color1 : COLOR1;
	float4 color : COLOR;
	float4 color2 : COLOR2;
	float4 color3 : COLOR3;
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
	r1 = r0.w + -g_otherParam.y;
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
	r0.w = dot(g_lightDir.xyz, r3.xyz);
	r2.xyz = normalize(r1.xyz);
	o.color1.xyz = r2.xyz * 0.5 + 0.5;
	r1.xyz = normalize(-i.texcoord1.xyz);
	r1.x = dot(r1.xyz, r2.xyz);
	r1.y = dot(g_lightDir.xyz, r2.xyz);
	r1.w = 0.5;
	r1.x = r1.x * g_olcParam.w + r1.w;
	r1.z = frac(r1.x);
	r1.x = -r1.z + r1.x;
	r1.z = r1.w + g_olcParam.y;
	r1.w = frac(r1.z);
	r1.z = -r1.w + r1.z;
	r1.z = 1 / r1.z;
	r1.x = r1.x * -r1.z + 1;
	r1.x = r1.x * g_olcParam.z;
	r1.z = r1.y;
	r0.w = -r0.w + r1.y;
	r0.w = r0.w + 1;
	r1.y = r1.z + 0.5;
	r1.z = frac(r1.y);
	r1.y = -r1.z + r1.y;
	r1.z = -r1.y + 1;
	r1.y = r1.y + g_olcParam.x;
	r1.x = r1.z * r1.x;
	r2.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r0.xyz = r0.xyz * r2.xyz;
	r2.xyz = r0.xyz * g_lightColor.xyz;
	r1.xzw = r1.xxx * r2.xyz;
	r2.x = 0.1 + -i.texcoord3.w;
	r2.xyz = r2.xxx * g_GroundHemisphereColor.xyz;
	r2.w = 0.1 + i.texcoord3.w;
	r2.xyz = g_SkyHemisphereColor.xyz * r2.www + r2.xyz;
	r2.xyz = r2.xyz + g_ambientRate.xyz;
	r2.xyz = r0.xyz * r2.xyz;
	o.color.xyz = r0.xyz;
	r0.xyz = r0.www * r2.xyz;
	o.color2.xyz = r0.xyz * r1.yyy + r1.xzw;
	o.color.w = 1;
	o.color1.w = g_otherParam.x;
	o.color2.w = g_otherParam.z;
	r0.yzw = float3(0.1, -1, 0);
	o.color3.xzw = g_ambientRate.www * r0.yzz + r0.wzz;
	o.color3.y = g_cubeParam2.w;

	return o;
}
