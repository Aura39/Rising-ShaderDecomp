float4 g_All_Offset;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
float4 g_GroundHemisphereColor;
sampler g_Normalmap_sampler;
sampler g_OcclusionSampler;
float4 g_SkinParam;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float4 g_lightColor;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_olcParam;
float4 g_otherParam;
float4 g_specParam;

struct PS_IN
{
	float3 color : COLOR;
	float4 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord8 : TEXCOORD8;
	float3 texcoord7 : TEXCOORD7;
};

struct PS_OUT
{
	float4 color : COLOR;
	float4 color1 : COLOR1;
	float4 color3 : COLOR3;
	float4 color2 : COLOR2;
};

PS_OUT main(PS_IN i)
{
	PS_OUT o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	float3 r4;
	float3 r5;
	float3 r6;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(g_Color_1_sampler, r0);
	r1 = r0.w + -g_otherParam.y;
	clip(r1);
	r1 = tex2D(g_OcclusionSampler, i.texcoord.zwzw);
	r2.xyz = r1.xyz + -1;
	r3.yw = float2(-1, 1);
	r2.xyz = g_ambientRate.www * r2.xyz + r3.yyy;
	r0.xyz = r0.xyz * r2.xyz;
	r2.xyz = g_ColorEnhance.xyz * i.color.xyz;
	r0.xyz = r0.xyz * r2.xyz;
	r2.xyz = -r1.xzw + 1;
	r1.xyz = g_ambientRate.www * r2.xyz + r1.xzw;
	o.color.xyz = r0.xyz * r1.zzz;
	r2 = tex2D(g_Normalmap_sampler, i.texcoord8.zwzw);
	r2.xyz = r2.xyz * 2 + -1;
	r4.x = r2.x * i.texcoord2.w;
	r4.yz = r2.yz * -1;
	r2.xyz = r4.xyz * g_normalmapRate.xxx;
	r4.xyz = normalize(r2.xyz);
	r2.xyz = normalize(i.texcoord2.xyz);
	r5.xyz = normalize(i.texcoord3.xyz);
	r6.xyz = r2.zxy * r5.yzx;
	r6.xyz = r2.yzx * r5.zxy + -r6.xyz;
	r6.xyz = r4.yyy * r6.xyz;
	r2.xyz = r4.xxx * r2.xyz + r6.xyz;
	r2.xyz = r4.zzz * r5.xyz + r2.xyz;
	r1.z = dot(g_lightDir.xyz, r5.xyz);
	r1.w = dot(r2.xyz, r2.xyz);
	r1.w = 1 / sqrt(r1.w);
	r2.xyw = r1.www * r2.xyz;
	r1.w = r2.z * -r1.w + 1;
	o.color1.xyz = r2.xyw * 0.5 + 0.5;
	r2.z = -g_specParam.x;
	r2.z = (-r2.z >= 0) ? 0 : 0.25;
	r3.x = g_otherParam.x;
	r3.x = r3.x + g_specParam.y;
	o.color1.w = r2.z + r3.x;
	r2.z = lerp(r1.y, r0.w, g_specParam.w);
	r0.w = r2.z * 1.000001;
	r1.y = abs(g_specParam.x);
	o.color3.z = r0.w * r1.y;
	r0.w = 0.1 + -i.texcoord3.w;
	r4.xyz = r0.www * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r4.xyz = g_SkyHemisphereColor.xyz * r0.www + r4.xyz;
	r4.xyz = r4.xyz + g_ambientRate.xyz;
	r5.xyz = r0.xyz * i.texcoord7.xyz;
	r5.xyz = r1.xxx * r5.xyz;
	r6.xyz = r0.xyz * r1.xxx;
	o.color.w = r1.x;
	r0.xyz = r0.xyz * g_lightColor.xyz;
	r4.xyz = r4.xyz * r6.xyz + r5.xyz;
	r5.xyz = r1.www * r6.xyz;
	r0.w = r1.w + -g_SkinParam.y;
	r1.xyw = r5.xyz * g_SkinParam.zzz;
	r2.z = dot(g_lightDir.xyz, r2.xyw);
	r1.z = -r1.z + r2.z;
	r2.z = r2.z;
	r1.z = r1.z * g_normalmapRate.x + r3.y;
	r4.xyz = r1.zzz * r4.xyz;
	r5.xyz = normalize(-i.texcoord1.xyz);
	r1.z = dot(r5.xyz, r2.xyw);
	r1.z = r1.z * g_olcParam.w + r3.w;
	r2.x = frac(r1.z);
	r1.z = r1.z + -r2.x;
	r2.x = r3.w + g_olcParam.y;
	r2.y = frac(r2.x);
	r2.x = -r2.y + r2.x;
	r2.x = 1 / r2.x;
	r1.z = r1.z * -r2.x + 1;
	r1.z = r1.z * g_olcParam.z;
	r2.x = r2.z + 0.5;
	r2.y = frac(r2.x);
	r2.x = -r2.y + r2.x;
	r2.y = -r2.x + 1;
	r2.x = r2.x + g_olcParam.x;
	r1.z = r1.z * r2.y;
	r0.xyz = r0.xyz * r1.zzz;
	r0.xyz = r4.xyz * r2.xxx + r0.xyz;
	r1.z = r3.y + -g_SkinParam.y;
	r1.z = 1 / r1.z;
	r1.z = r0.w * r1.z;
	r0.w = r0.w;
	r2.x = frac(-r0.w);
	r0.w = r0.w + r2.x;
	r0.w = r0.w * r1.z;
	o.color2.xyz = r1.xyw * r0.www + r0.xyz;
	r0.x = r2.z * 0.5 + 0.5;
	r0.x = r0.x * r0.x;
	o.color3.x = lerp(r0.x, r2.z, g_SkinParam.x);
	o.color2.w = g_otherParam.z;
	r0.z = g_specParam.z;
	o.color3.yw = r0.zz * 0;

	return o;
}
