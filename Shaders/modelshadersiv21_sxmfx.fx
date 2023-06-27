sampler A_Occ_sampler;
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
float4 prefogcolor_enhance;
float4 specularParam;

struct PS_IN
{
	float3 color : COLOR;
	float4 texcoord : TEXCOORD;
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
	float4 r4;
	float3 r5;
	r0 = g_All_Offset.xyxy + i.texcoord.zwxy;
	r1 = tex2D(Color_1_sampler, r0.zwzw);
	r0 = tex2D(A_Occ_sampler, r0);
	r2 = r1.w + -0.8;
	clip(r2);
	r2.xy = -r1.yy + r1.xz;
	r0.w = max(abs(r2.x), abs(r2.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r1.xz = (r0.ww >= 0) ? r1.yy : r1.xz;
	r2.xyz = r1.xyz * i.color.xyz + specularParam.www;
	r1.xyz = r1.xyz * i.color.xyz;
	r3.xy = -r0.yy + r0.xz;
	r0.w = max(abs(r3.x), abs(r3.y));
	r0.w = r0.w + -0.015625;
	r1.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = (r0.w >= 0) ? -0 : -1;
	r0.w = r0.w + r1.w;
	r0.w = (r0.w >= 0) ? -r0.w : -0;
	r0.xz = (r0.ww >= 0) ? r0.yy : r0.xz;
	r3.xyz = r0.xyz * r1.xyz;
	r3.xyz = r3.xyz * ambient_rate.xyz;
	r0.w = dot(lightpos.xyz, i.texcoord3.xyz);
	r1.w = r0.w + -0.5;
	r2.w = max(r1.w, 0);
	r0.xyz = r0.xyz + r2.www;
	r1.xyz = r0.xyz * r1.xyz;
	r1.w = 1 / i.texcoord7.w;
	r4.xy = r1.ww * i.texcoord7.xy;
	r4.xy = r4.xy * float2(0.5, -0.5) + 0.5;
	r4.xy = r4.xy + g_TargetUvParam.xy;
	r4 = tex2D(Shadow_Tex_sampler, r4);
	r1.w = r4.z + g_ShadowUse.x;
	r4.xyz = r0.www * light_Color.xyz;
	r4.xyz = r4.xyz * r1.www + i.texcoord2.xyz;
	r1.xyz = r1.xyz * r4.xyz;
	r1.xyz = r3.xyz * ambient_rate_rate.xyz + r1.xyz;
	r2.w = (-r0.w >= 0) ? 0 : 1;
	r0.w = r0.w * r2.w;
	r3.xyz = r0.www * light_Color.xyz;
	r0.w = dot(-i.texcoord1.xyz, -i.texcoord1.xyz);
	r0.w = 1 / sqrt(r0.w);
	r4.xyz = -i.texcoord1.xyz * r0.www + lightpos.xyz;
	r5.xyz = normalize(r4.xyz);
	r0.w = dot(r5.xyz, i.texcoord3.xyz);
	r2.w = (-r0.w >= 0) ? 0 : r2.w;
	r3.w = pow(r0.w, specularParam.z);
	r0.w = r2.w * r3.w;
	r3.xyz = r0.www * r3.xyz;
	r3.xyz = r1.www * r3.xyz;
	r0.xyz = r0.xyz * r3.xyz;
	r0.w = abs(specularParam.x);
	r0.xyz = r0.www * r0.xyz;
	r0.xyz = r0.xyz * r2.xyz + r1.xyz;
	r1.xyz = fog.xyz;
	r0.xyz = r0.xyz * prefogcolor_enhance.xyz + -r1.xyz;
	o.xyz = i.texcoord2.www * r0.xyz + fog.xyz;
	o.w = prefogcolor_enhance.w;

	return o;
}
