sampler Color_1_sampler;
sampler Shadow_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 light_Color;
float4 lightpos;
float4 muzzle_light;
float4 muzzle_lightpos;
float4 point_light1;
float4 point_lightpos1;
float4 prefogcolor_enhance;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
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
	float3 r3;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.01;
	clip(r1);
	r1.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r2.xyz = normalize(r1.xyz);
	r1.x = dot(r2.xyz, i.texcoord3.xyz);
	r1.xyz = r1.xxx * point_light1.xyz;
	r1.xyz = r1.xyz * i.texcoord8.xxx;
	r2.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r3.xyz = normalize(r2.xyz);
	r1.w = dot(r3.xyz, i.texcoord3.xyz);
	r2.xyz = r1.www * muzzle_light.xyz;
	r1.xyz = r2.xyz * i.texcoord8.zzz + r1.xyz;
	r1.w = 1 / i.texcoord7.w;
	r2.xy = r1.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(Shadow_Tex_sampler, r2);
	r1.w = r2.z + g_ShadowUse.x;
	r2.x = dot(lightpos.xyz, i.texcoord3.xyz);
	r2.xyz = r2.xxx * light_Color.xyz;
	r1.xyz = r2.xyz * r1.www + r1.xyz;
	r2.xy = -r0.yy + r0.xz;
	r1.w = max(abs(r2.x), abs(r2.y));
	r1.w = r1.w + -0.015625;
	r2.x = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.x;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r0.xz = (r1.ww >= 0) ? r0.yy : r0.xz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r1.xyz = r1.xyz * r0.xyz;
	r0.xyz = r0.xyz * ambient_rate.xyz;
	r0.xyz = r0.xyz * ambient_rate_rate.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;

	return o;
}
