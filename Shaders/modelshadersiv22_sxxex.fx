sampler Color_1_sampler;
sampler ShadowCast_Tex_sampler;
float4 ambient_rate;
float4 ambient_rate_rate;
float3 fog;
float4 g_All_Offset;
float2 g_ShadowFarInvPs;
float g_ShadowUse;
float4 g_TargetUvParam;
float4 light_Color;
float4 lightpos;
float4 prefogcolor_enhance;
float4 specularParam;

struct PS_IN
{
	float2 texcoord : TEXCOORD;
	float3 texcoord1 : TEXCOORD1;
	float4 texcoord2 : TEXCOORD2;
	float3 texcoord3 : TEXCOORD3;
	float4 texcoord7 : TEXCOORD7;
};

float4 main(PS_IN i) : COLOR
{
	float4 o;

	float4 r0;
	float4 r1;
	float4 r2;
	float4 r3;
	r0.xy = g_All_Offset.xy + i.texcoord.xy;
	r0 = tex2D(Color_1_sampler, r0);
	r1 = r0.w + -0.01;
	clip(r1);
	r1.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r1.x = 1 / sqrt(r1.x);
	r1.xyz = -i.texcoord1.xyz * r1.xxx + lightpos.xyz;
	r2.xyz = normalize(r1.xyz);
	r1.x = dot(r2.xyz, i.texcoord3.xyz);
	r2.x = pow(r1.x, specularParam.z);
	r1.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.z = (-r1.y >= 0) ? 0 : 1;
	r1.x = (-r1.x >= 0) ? 0 : r1.z;
	r1.z = r1.y * r1.z;
	r2.yzw = r1.yyy * light_Color.xyz;
	r1.yzw = r1.zzz * light_Color.xyz;
	r1.x = r2.x * r1.x;
	r1.xyz = r1.xxx * r1.yzw;
	r1.w = 1 / i.texcoord7.w;
	r3.xy = r1.ww * i.texcoord7.xy;
	r3.xy = r3.xy * float2(0.5, -0.5) + 0.5;
	r3.xy = r3.xy + g_TargetUvParam.xy;
	r3 = tex2D(ShadowCast_Tex_sampler, r3);
	r1.w = i.texcoord7.z * g_ShadowFarInvPs.y + -g_ShadowFarInvPs.x;
	r1.w = -r1.w + 1;
	r1.w = -r3.x + r1.w;
	r1.w = r1.w + g_ShadowUse.x;
	r2.x = frac(-r1.w);
	r1.w = r1.w + r2.x;
	r1.xyz = r1.www * r1.xyz;
	r2.xyz = r2.yzw * r1.www + i.texcoord2.xyz;
	r1.w = abs(specularParam.x);
	r1.xyz = r1.www * r1.xyz;
	r3.xy = -r0.yy + r0.xz;
	r1.w = max(abs(r3.x), abs(r3.y));
	r1.w = r1.w + -0.015625;
	r2.w = (-r1.w >= 0) ? 0 : 1;
	r1.w = (r1.w >= 0) ? -0 : -1;
	r1.w = r1.w + r2.w;
	r1.w = (r1.w >= 0) ? -r1.w : -0;
	r0.xz = (r1.ww >= 0) ? r0.yy : r0.xz;
	r0.w = r0.w * prefogcolor_enhance.w;
	o.w = r0.w;
	r2.xyz = r2.xyz * r0.xyz;
	r3.xyz = r0.xyz * ambient_rate.xyz;
	r0.xyz = r0.xyz + specularParam.www;
	r2.xyz = r3.xyz * ambient_rate_rate.xyz + r2.xyz;
	r0.xyz = r1.xyz * r0.xyz + r2.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;

	return o;
}
