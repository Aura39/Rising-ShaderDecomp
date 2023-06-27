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
float4 specularParam;

struct PS_IN
{
	float3 color : COLOR;
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
	float3 r4;
	float3 r5;
	r0.x = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.x = 1 / sqrt(r0.x);
	r0.xyz = -i.texcoord1.xyz * r0.xxx + lightpos.xyz;
	r1.xyz = normalize(r0.xyz);
	r0.x = dot(r1.xyz, i.texcoord3.xyz);
	r1.x = pow(r0.x, specularParam.z);
	r0.y = dot(lightpos.xyz, i.texcoord3.xyz);
	r0.z = (-r0.y >= 0) ? 0 : 1;
	r0.y = r0.y * r0.z;
	r0.x = (-r0.x >= 0) ? 0 : r0.z;
	r0.x = r1.x * r0.x;
	r0.yzw = r0.yyy * light_Color.xyz;
	r0.xyz = r0.xxx * r0.yzw;
	r1.xy = g_All_Offset.xy + i.texcoord.xy;
	r1 = tex2D(Color_1_sampler, r1);
	r0.xyz = r0.xyz * r1.www;
	r0.w = 1 / i.texcoord7.w;
	r2.xy = r0.ww * i.texcoord7.xy;
	r2.xy = r2.xy * float2(0.5, -0.5) + 0.5;
	r2.xy = r2.xy + g_TargetUvParam.xy;
	r2 = tex2D(Shadow_Tex_sampler, r2);
	r0.w = r2.z + g_ShadowUse.x;
	r0.xyz = r0.www * r0.xyz;
	r2.xyz = ambient_rate.xyz;
	r2.xyz = r0.www * ambient_rate_rate.xyz + r2.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r3.xy = -r1.yy + r1.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r1.xz = (r0.ww >= 0) ? r1.yy : r1.xz;
	r0.w = 1 / ambient_rate.w;
	r1.xyz = r0.www * r1.xyz;
	r3.xyz = r1.xyz * i.color.xyz + specularParam.www;
	r1.xyz = r1.xyz * i.color.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r3.xyz = point_lightpos1.xyz + -i.texcoord1.xyz;
	r4.xyz = normalize(r3.xyz);
	r0.w = dot(r4.xyz, i.texcoord3.xyz);
	r3.xyz = r0.www * point_light1.xyz;
	r3.xyz = r3.xyz * i.texcoord8.xxx;
	r4.xyz = muzzle_lightpos.xyz + -i.texcoord1.xyz;
	r5.xyz = normalize(r4.xyz);
	r0.w = dot(r5.xyz, i.texcoord3.xyz);
	r4.xyz = r0.www * muzzle_light.xyz;
	r3.xyz = r4.xyz * i.texcoord8.zzz + r3.xyz;
	r2.xyz = r2.xyz + r3.xyz;
	r0.xyz = r1.xyz * r2.xyz + r0.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord8.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
