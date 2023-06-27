float4 g_All_Offset;
float4 g_BlurParam;
float4 g_ColorEnhance;
sampler g_Color_1_sampler;
sampler g_Color_2_sampler;
float4 g_GroundHemisphereColor;
sampler g_Normalmap2_sampler;
sampler g_Normalmap_sampler;
float4 g_SkyHemisphereColor;
float4 g_ambientRate;
float3 g_damageBlendCol;
float3 g_lightDir;
float4 g_normalmapRate;
float4 g_otherParam;
float4 g_specParam;

struct PS_IN
{
	float3 color : COLOR;
	float2 texcoord : TEXCOORD;
	float4 texcoord2 : TEXCOORD2;
	float4 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
	float2 texcoord8 : TEXCOORD8;
};

struct PS_OUT
{
	float4 color1 : COLOR1;
	float4 color3 : COLOR3;
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
	r0.xy = g_All_Offset.xy;
	r0.zw = i.texcoord.xy * g_normalmapRate.yz + r0.xy;
	r1 = tex2D(g_Normalmap_sampler, r0.zwzw);
	r0.xy = i.texcoord.xy * g_otherParam.xy + r0.xy;
	r0 = tex2D(g_Normalmap2_sampler, r0);
	r2.xyz = lerp(r0.xyz, r1.xyz, i.color.yyy);
	r0.x = r2.x * 2 + -1;
	r1.yz = r2.yz * -2 + float2(-2, 1);
	r0.y = 1 + -i.texcoord2.w;
	r0.y = -r0.y + 1;
	r1.x = r0.y * r0.x;
	r0.xyz = r1.xyz * g_normalmapRate.xxx;
	r1.xyz = normalize(i.texcoord2.xyz);
	r2.xyz = normalize(i.texcoord3.xyz);
	r3.xyz = r1.zxy * r2.yzx;
	r3.xyz = r1.yzx * r2.zxy + -r3.xyz;
	r3.xyz = r0.yyy * r3.xyz;
	r0.xyw = r0.xxx * r1.xyz + r3.xyz;
	r0.xyz = r0.zzz * r2.xyz + r0.xyw;
	r0.w = dot(g_lightDir.xyz, r2.xyz);
	r1.xyz = normalize(r0.xyz);
	o.color1.xyz = r1.xyz * 0.5 + 0.5;
	r0.x = dot(g_lightDir.xyz, r1.xyz);
	r0.x = -r0.w + r0.x;
	r0.z = 1;
	r0.x = r0.x * g_normalmapRate.x + r0.z;
	r1.x = g_otherParam.x;
	o.color1.w = r1.x + g_specParam.y;
	r0.y = 1 / i.texcoord7.z;
	r0.yz = r0.yy * i.texcoord8.xy;
	r0.w = 1 / i.texcoord7.w;
	r0.yz = i.texcoord7.xy * r0.ww + -r0.yz;
	r1.x = 0.5;
	o.color3.xy = r0.yz * g_BlurParam.xy + r1.xx;
	r0.yz = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(g_Color_1_sampler, r0.yzzw);
	r0.y = r1.w * g_specParam.x;
	o.color3.z = r0.y * 1.000001;
	r0.yz = g_All_Offset.zw * i.texcoord.xy;
	r2 = tex2D(g_Color_2_sampler, r0.yzzw);
	r0.y = r2.w * i.color.x;
	r3.xyz = lerp(r2.xyz, r1.xyz, r0.yyy);
	r0.yzw = g_damageBlendCol.xyz * i.color.zzz;
	r0.yzw = r3.xyz * g_ColorEnhance.xyz + r0.yzw;
	r1.xyz = r0.xxx * r0.yzw;
	o.color.xyz = r0.yzw;
	r0.x = 0.1 + -i.texcoord3.w;
	r0.xyz = r0.xxx * g_GroundHemisphereColor.xyz;
	r0.w = 0.1 + i.texcoord3.w;
	r0.xyz = g_SkyHemisphereColor.xyz * r0.www + r0.xyz;
	r0.xyz = r0.xyz + g_ambientRate.xyz;
	o.color2.xyz = r1.xyz * r0.xyz;
	o.color.w = 1;
	o.color2.w = 0;
	o.color3.w = g_specParam.z;

	return o;
}
